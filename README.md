
# Task 
| カラム名 | データ型 |
| ---- | ---- |
| user_id | index |
| task_name | string |
| derails | text |
| deadline | date |
| priority | integer |
| status | string |

# User
| カラム名 | データ型 |
| ---- | ----|
| name | string |
| email | string |
| password_digest | string |

# LabelLink
| カラム名 | データ型 |
| ---- | ---- |
| task_id | index |
| label_id | index |

# Label
| カラム名 | データ型 |
| ---- | ---- |
| label_name | string |
