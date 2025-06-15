# 🎓 GradGate

**Version:** 1.5.0  
**Platforms Supported:** Android (Tablet), Linux  
**Database:** SQLite (via `sqflite`)  
**Download:** [Releases](https://github.com/aswin-asokan/GradGate/releases/tag/v1.5.0)

### 💾 Linux Runtime Requirements

If you're running the Linux build of GradGate make sure the following system dependencies are installed:

```bash
sudo apt update
sudo apt install sqlite3 libsqlite3-dev
```

| Package        | Purpose                                           |
| -------------- | ------------------------------------------------- |
| sqlite3        | SQLite CLI (for testing/debugging if needed)      |
| libsqlite3-dev | Required for Flutter’s sqflite_common_ffi backend |

> No need to install Flutter or Dart on the target system — just ensure these libraries exist if you're running the prebuilt binary.

---

## 📖 About

GradGate is a lightweight and powerful placement management simulation app built with Flutter. It helps simulate and manage a simplified version of a college placement system using a local SQLite database. GradGate is designed to mimic the working of a real-world placement system. It supports functionality for students, employers, and colleges—providing a seamless experience for job applications, employer listings, and candidate management, all handled locally without a remote backend.

> 🔔 **Note**: This app is a simulation tool and runs completely on a local database. No internet or server backend is used.

## 🚀 Key Features

- 👩‍🎓 **Student Module**

  - View and apply for jobs based on department eligibility.
  - Receive application status and employer replies.
  - Profile with editable "About Me" section using rich text.

- 🏢 **Employer Module**

  - Post jobs with filters by eligible departments.
  - View applicant lists and update application statuses (selected, waiting, rejected).
  - View student profiles with resume-style information.

- 🏫 **College Module**

  - Register and manage student entries.
  - Track placement analytics like total applicants, selected students, average salary, etc.

- 🔐 **Authentication System**

  - Separate login for students, colleges, and employers.

- 📊 **Analytics**

  - Student, college and company dashboards showing job and application metrics.

- 💾 **Local Persistence**
  - Entire system functions offline using `sqflite`.

---

## 🛠️ Table Schema Overview

### `students`

| Column     | Type    | Description          |
| ---------- | ------- | -------------------- |
| id         | INTEGER | Primary key          |
| name       | TEXT    | Student name         |
| email      | TEXT    | Unique email         |
| phone      | TEXT    | Contact number       |
| department | TEXT    | E.g., CSE, AIML, CE  |
| college    | TEXT    | College name         |
| about      | TEXT    | JSON rich text       |
| link       | TEXT    | Profile picture path |

---

### `employers`

| Column   | Type    | Description        |
| -------- | ------- | ------------------ |
| id       | INTEGER | Primary key        |
| name     | TEXT    | Company name       |
| email    | TEXT    | Unique email       |
| location | TEXT    | Company location   |
| link     | TEXT    | Logo/profile image |

---

### `jobs`

| Column      | Type    | Description                                  |
| ----------- | ------- | -------------------------------------------- |
| id          | INTEGER | Primary key                                  |
| employer_id | INTEGER | FK to `employers(id)`                        |
| title       | TEXT    | Job title                                    |
| description | TEXT    | Job description                              |
| salary      | TEXT    | Offered salary (stored as TEXT)              |
| branches    | TEXT    | Comma-separated dept list (e.g., `CSE,AIML`) |
| status      | TEXT    | `active`, `closed`, `in progress`            |
| date        | TEXT    | Date posted                                  |
| type        | TEXT    | Job type (Intern, Full-time)                 |

---

### `applied`

| Column     | Type    | Description                           |
| ---------- | ------- | ------------------------------------- |
| id         | INTEGER | Primary key                           |
| job_id     | INTEGER | FK to `jobs(id)`                      |
| student_id | INTEGER | FK to `students(id)`                  |
| status     | TEXT    | `waiting`, `selected`, `rejected`     |
| reply      | TEXT    | `accepted`, `declined` (from student) |

---

## 🧾 Changelog

### v1.5.0

- Switched backend from MySQL/PHP to local SQLite using `sqflite`.
- Added support for offline functionality and improved performance.
- Platform-specific enhancements for Android (tablet) and Linux.

### v1.0.0

- Initial release using MySQL and PHP backend.

---

## 📱 App Screenshots

| Screenshot                                                                               | Screenshot                                                                               |
| ---------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------- |
| ![ss1](https://github.com/user-attachments/assets/428909aa-c139-4c62-bc8b-c4fd8e5a6c0f)  | ![ss2](https://github.com/user-attachments/assets/383324d2-de18-4d0f-bbc1-ac4d270fdb84)  |
| ![ss3](https://github.com/user-attachments/assets/b6aade59-bb87-4ecc-9ede-af22b78cdb55)  | ![ss4](https://github.com/user-attachments/assets/3227cd1f-5fc7-41f1-b64c-2be52c82e204)  |
| ![ss5](https://github.com/user-attachments/assets/21c7f26f-0fe5-4885-8b68-6e8ed628fa03)  | ![ss6](https://github.com/user-attachments/assets/0c5f7e42-a5f2-49e2-89e9-1bf38e54835e)  |
| ![ss7](https://github.com/user-attachments/assets/f2cc8a4c-1ea4-4241-9713-615ad449d459)  | ![ss8](https://github.com/user-attachments/assets/e46b0f8a-afd7-46ad-b3d3-3868ceb7c078)  |
| ![ss9](https://github.com/user-attachments/assets/41eddb0f-b807-4d1a-8003-b3e73b66c0de)  | ![ss10](https://github.com/user-attachments/assets/b9331a87-85f1-4136-8e77-d95fe8e25b3b) |
| ![ss11](https://github.com/user-attachments/assets/fb512e21-58c3-4664-94be-c03c4f37dafb) | ![ss12](https://github.com/user-attachments/assets/57ae04b0-0cdc-488f-9088-5bc8041594c6) |
| ![ss13](https://github.com/user-attachments/assets/66092e41-39dc-4c7f-b97e-b0af6460d8f2) | ![ss14](https://github.com/user-attachments/assets/05ec0306-7143-48fb-adc9-9ac2133415ae) |

## 🔖 References:

[Job portal UI by Ronas IT | UI/UX Team](https://dribbble.com/shots/21587286-Job-Search-Platform)

## 📬 Feedback or Contributions

Open an issue or fork the repo to contribute ideas or fixes.

---

### 🧪 Simulation Mode

This app is intended to **simulate** how a real-world placement management system works in a fully **offline environment** for demonstration and educational purposes.

---
