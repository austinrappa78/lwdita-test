---
author:
  - Ausitn Rappa
source: Markdown
publisher: Publisher
permissions: Permissions
audience: Users
category: Category
keyword:
  - Keyword1
  - Keyword2
resourceid:
  - Resourceid1
  - Resourceid2
workflow: review
---

# Hardware Compatibility

Knox Recovery is designed to work seamlessly across a wide range of hardware configurations and network interface cards. This compatibility matrix provides comprehensive information about tested and supported hardware combinations to help you plan your deployment.

Before installing Knox Recovery, review this matrix to ensure your hardware configuration is supported. If you have questions about specific hardware not listed here, contact Veracity Support for additional guidance.

The following table is updated from the latest NIC Compatibility Matrix:

| NIC Model      | Supported OS         | Notes                      |
|----------------|----------------------|----------------------------|
| Intel X520     | RHEL 8, Ubuntu 22    | Requires firmware upgrade  |
| Broadcom 57810 | Windows Server 2022  | Tested with driver v2.14   |

_This table is maintained as a shared reference. Copy and paste from GDocs is supported._

## Platform Feature Support

Knox Recovery offers different feature sets depending on your operating system and deployment environment. The table below outlines which features are available on each platform, including any special requirements or limitations.

Note that some features marked as "Beta" are available for testing purposes but should not be used in production environments without consulting with Veracity Support. Production deployments should use only generally available (GA) features.

Feature List

| Feature         | Supported Platforms | Notes                |
| --------------- | :-----------------:| --------------------:|
| Fast Sync       |   Windows, Linux    |         _Beta Only_  ||
| Secure Backup   |   **All**           |   Requires license   |
| Cloud Restore   |   macOS, Linux      |    Coming soon       |

## System Requirements and Recommendations

To ensure optimal performance, Knox Recovery requires specific system resources and configurations. These requirements may vary based on the features you plan to use and the size of your data sets.

For enterprise deployments handling large volumes of data, we recommend exceeding the minimum requirements to ensure consistent performance during peak backup and recovery operations.

| First Header | Second Header | Third Header |
| ------------ | :-----------: | -----------: |
| Content      |          _Long Cell_        ||
| Content      |   **Cell**    |         Cell |

For the most up-to-date compatibility information and detailed system requirements, refer to the Knox Recovery Installation Guide or contact your Veracity