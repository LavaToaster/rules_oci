<!-- Generated with Stardoc: http://skydoc.bazel.build -->

A repository rule to pull image layers using Bazel's downloader.

Typical usage in `WORKSPACE.bazel`:

```starlark
load("@rules_oci//oci:pull.bzl", "oci_pull")

# A single-arch base image
oci_pull(
    name = "distroless_java",
    digest = "sha256:161a1d97d592b3f1919801578c3a47c8e932071168a96267698f4b669c24c76d",
    image = "gcr.io/distroless/java17",
)

# A multi-arch base image
oci_pull(
    name = "distroless_static",
    digest = "sha256:c3c3d0230d487c0ad3a0d87ad03ee02ea2ff0b3dcce91ca06a1019e07de05f12",
    image = "gcr.io/distroless/static",
    platforms = [
        "linux/amd64",
        "linux/arm64",
    ],
)
```

Now you can refer to these as a base layer in `BUILD.bazel`.
The target is named the same as the external repo, so you can use a short label syntax:

```
oci_image(
    name = "app",
    base = "@distroless_static",
    ...
)
```


<a id="#oci_alias"></a>

## oci_alias

<pre>
oci_alias(<a href="#oci_alias-name">name</a>, <a href="#oci_alias-platforms">platforms</a>, <a href="#oci_alias-repo_mapping">repo_mapping</a>, <a href="#oci_alias-target_name">target_name</a>)
</pre>



**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="oci_alias-name"></a>name |  A unique name for this repository.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="oci_alias-platforms"></a>platforms |  -   | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: Label -> String</a> | optional | {} |
| <a id="oci_alias-repo_mapping"></a>repo_mapping |  A dictionary from local repository name to global repository name. This allows controls over workspace dependency resolution for dependencies of this repository.&lt;p&gt;For example, an entry <code>"@foo": "@bar"</code> declares that, for any time this repository depends on <code>@foo</code> (such as a dependency on <code>@foo//some:target</code>, it should actually resolve that dependency within globally-declared <code>@bar</code> (<code>@bar//some:target</code>).   | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: String -> String</a> | required |  |
| <a id="oci_alias-target_name"></a>target_name |  -   | String | optional | "" |


<a id="#oci_pull_rule"></a>

## oci_pull_rule

<pre>
oci_pull_rule(<a href="#oci_pull_rule-name">name</a>, <a href="#oci_pull_rule-config">config</a>, <a href="#oci_pull_rule-identifier">identifier</a>, <a href="#oci_pull_rule-image">image</a>, <a href="#oci_pull_rule-platform">platform</a>, <a href="#oci_pull_rule-repo_mapping">repo_mapping</a>, <a href="#oci_pull_rule-target_name">target_name</a>, <a href="#oci_pull_rule-toolchain_name">toolchain_name</a>)
</pre>



**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="oci_pull_rule-name"></a>name |  A unique name for this repository.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="oci_pull_rule-config"></a>config |  Label to a .docker/config.json file. by default this is generated by oci_auth_config in oci_register_toolchains macro.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | @oci_auth_config//:config.json |
| <a id="oci_pull_rule-identifier"></a>identifier |  The digest or tag of the manifest file   | String | required |  |
| <a id="oci_pull_rule-image"></a>image |  The name of the image we are fetching, e.g. gcr.io/distroless/static   | String | required |  |
| <a id="oci_pull_rule-platform"></a>platform |  platform in <code>os/arch</code> format, for multi-arch images   | String | optional | "" |
| <a id="oci_pull_rule-repo_mapping"></a>repo_mapping |  A dictionary from local repository name to global repository name. This allows controls over workspace dependency resolution for dependencies of this repository.&lt;p&gt;For example, an entry <code>"@foo": "@bar"</code> declares that, for any time this repository depends on <code>@foo</code> (such as a dependency on <code>@foo//some:target</code>, it should actually resolve that dependency within globally-declared <code>@bar</code> (<code>@bar//some:target</code>).   | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: String -> String</a> | required |  |
| <a id="oci_pull_rule-target_name"></a>target_name |  Name given for the image target, e.g. 'image'   | String | required |  |
| <a id="oci_pull_rule-toolchain_name"></a>toolchain_name |  Value of name attribute to the oci_register_toolchains call in the workspace.   | String | optional | "oci" |


<a id="#pin_tag"></a>

## pin_tag

<pre>
pin_tag(<a href="#pin_tag-name">name</a>, <a href="#pin_tag-config">config</a>, <a href="#pin_tag-image">image</a>, <a href="#pin_tag-repo_mapping">repo_mapping</a>, <a href="#pin_tag-tag">tag</a>, <a href="#pin_tag-toolchain_name">toolchain_name</a>)
</pre>



**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="pin_tag-name"></a>name |  A unique name for this repository.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="pin_tag-config"></a>config |  Label to a .docker/config.json file. by default this is generated by oci_auth_config in oci_register_toolchains macro.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | @oci_auth_config//:config.json |
| <a id="pin_tag-image"></a>image |  The name of the image we are fetching, e.g. <code>gcr.io/distroless/static</code>   | String | required |  |
| <a id="pin_tag-repo_mapping"></a>repo_mapping |  A dictionary from local repository name to global repository name. This allows controls over workspace dependency resolution for dependencies of this repository.&lt;p&gt;For example, an entry <code>"@foo": "@bar"</code> declares that, for any time this repository depends on <code>@foo</code> (such as a dependency on <code>@foo//some:target</code>, it should actually resolve that dependency within globally-declared <code>@bar</code> (<code>@bar//some:target</code>).   | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: String -> String</a> | required |  |
| <a id="pin_tag-tag"></a>tag |  The tag being used, e.g. <code>latest</code>   | String | required |  |
| <a id="pin_tag-toolchain_name"></a>toolchain_name |  Value of name attribute to the oci_register_toolchains call in the workspace.   | String | optional | "oci" |


<a id="#oci_pull"></a>

## oci_pull

<pre>
oci_pull(<a href="#oci_pull-name">name</a>, <a href="#oci_pull-image">image</a>, <a href="#oci_pull-platforms">platforms</a>, <a href="#oci_pull-digest">digest</a>, <a href="#oci_pull-tag">tag</a>, <a href="#oci_pull-reproducible">reproducible</a>, <a href="#oci_pull-toolchain_name">toolchain_name</a>)
</pre>

Repository macro to fetch image manifest data from a remote docker registry.

To use the resulting image, you can use the `@wkspc` shorthand label, for example
if `name = "distroless_base"`, then you can just use `base = "@distroless_base"`
in rules like `oci_image`.

> This shorthand syntax is broken on the command-line prior to Bazel 6.2.
> See https://github.com/bazelbuild/bazel/issues/4385


**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="oci_pull-name"></a>name |  repository with this name is created   |  none |
| <a id="oci_pull-image"></a>image |  the remote image without a tag, such as gcr.io/bazel-public/bazel   |  none |
| <a id="oci_pull-platforms"></a>platforms |  for multi-architecture images, a dictionary of the platforms it supports This creates a separate external repository for each platform, avoiding fetching layers.   |  <code>None</code> |
| <a id="oci_pull-digest"></a>digest |  the digest string, starting with "sha256:", "sha512:", etc. If omitted, instructions for pinning are provided.   |  <code>None</code> |
| <a id="oci_pull-tag"></a>tag |  a tag to choose an image from the registry. Exactly one of <code>tag</code> and <code>digest</code> must be set. Since tags are mutable, this is not reproducible, so a warning is printed.   |  <code>None</code> |
| <a id="oci_pull-reproducible"></a>reproducible |  Set to False to silence the warning about reproducibility when using <code>tag</code>.   |  <code>True</code> |
| <a id="oci_pull-toolchain_name"></a>toolchain_name |  Value of name attribute to the oci_register_toolchains call in the workspace.   |  <code>"oci"</code> |


