"Public API"

load("//oci/private:tarball.bzl", _oci_tarball = "oci_tarball")
load("//oci/private:image.bzl", _oci_image = "oci_image")
load("//oci/private:image_index.bzl", _oci_image_index = "oci_image_index")
load("//oci/private:push.bzl", _oci_push = "oci_push")
load("//oci/private:structure_test.bzl", _structure_test = "structure_test")
load("@bazel_skylib//lib:types.bzl", "types")
load("@bazel_skylib//rules:write_file.bzl", "write_file")

oci_tarball = _oci_tarball
oci_image_rule = _oci_image
oci_image_index = _oci_image_index
oci_push_rule = _oci_push
structure_test = _structure_test

def oci_image(name, labels = None, annotations = None, **kwargs):
    """Macro wrapper around [oci_image_rule](#oci_image_rule).

    Allows labels and annotations to be provided as a dictionary, in addition to a text file.
    See https://github.com/opencontainers/image-spec/blob/main/annotations.md

    Label/annotation keys like `org.opencontainers.image.created` and `org.opencontainers.image.version`
    may be supplied with non-deterministic information when bazel is run with `--stamp`; see the example in
    [/examples/labels/BUILD.bazel](https://github.com/bazel-contrib/rules_oci/blob/main/examples/labels/BUILD.bazel).

    Args:
        name: name of resulting oci_image_rule
        labels: Labels for the image config. See documentation above.
        annotations: Annotations for the image config. See documentation above.
        **kwargs: other named arguments to [oci_image_rule](#oci_image_rule)
    """
    if types.is_dict(annotations):
        annotations_label = "_{}_write_annotations".format(name)
        write_file(
            name = annotations_label,
            out = "_{}.annotations.txt".format(name),
            content = ["{}={}".format(key, value) for (key, value) in annotations.items()],
        )
        annotations = annotations_label

    if types.is_dict(labels):
        labels_label = "_{}_write_labels".format(name)
        write_file(
            name = labels_label,
            out = "_{}.labels.txt".format(name),
            content = ["{}={}".format(key, value) for (key, value) in labels.items()],
        )
        labels = labels_label

    oci_image_rule(
        name = name,
        annotations = annotations,
        labels = labels,
        **kwargs
    )

def oci_push(name, repotags = None, **kwargs):
    """Macro wrapper around [oci_push_rule](#oci_push_rule).

    Allows the tags attribute to be a list of strings in addition to a text file.

    Args:
        name: name of resulting oci_push_rule
        repotags: a list of tags to apply to the image after pushing,
            or a label of a file containing tags one-per-line.
            See [stamped_tags](https://github.com/bazel-contrib/rules_oci/blob/main/examples/push/stamp_tags.bzl)
            as one example of a way to produce such a file.
        **kwargs: other named arguments to [oci_push_rule](#oci_push_rule).
    """
    if types.is_list(repotags):
        tags_label = "_{}_write_tags".format(name)
        write_file(
            name = tags_label,
            out = "_{}.tags.txt".format(name),
            content = repotags,
        )
        repotags = tags_label

    oci_push_rule(
        name = name,
        repotags = repotags,
        **kwargs
    )
