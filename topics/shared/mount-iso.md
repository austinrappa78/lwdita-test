---
title: Mount ISO Procedure
---

## Mounting an ISO File in Knox

1. Upload the ISO to the Knox server using SCP or your preferred method.
2. Run the following command to mount the ISO:
   ```bash
   sudo mount -o loop /path/to/iso /mnt/iso
3. Verify that the ISO contents are accessible:
   ```bash
   ls /mnt/iso