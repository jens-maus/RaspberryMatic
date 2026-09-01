# OpenCCU-Base rootfs patches

The numbered directories are the editable source of truth. Each file to be
changed is stored as a pristine `rootfs/path.orig` file and its corresponding
modified `rootfs/path` file. The adjacent numbered `.patch` files are generated
artifacts consumed by Buildroot after OpenCCU-Base has populated `build/rootfs`.

Regenerate after editing a modified file:

```sh
./create_patches.sh
./create_patches.sh --check
```

Refresh the complete stack for a newer OpenCCU-Base revision using an unpatched
rootfs generated with `OPENCCU_BASE_ENABLE_ROOTFS_PATCHING=NO`:

```sh
./update_patchfiles.sh \
  /absolute/path/to/pristine/build/rootfs \
  /absolute/path/to/extracted/OpenCCU-Base
```

The refresh deliberately fails at the first incompatible patch. Resolve that
patch's semantic change in its modified file, regenerate, and repeat. Do not
generate patches automatically during a normal Buildroot build; generated
patches are committed so they remain reproducible and reviewable.
