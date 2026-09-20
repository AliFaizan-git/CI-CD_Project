# Express API with CI/CD Deployment to AWS EC2

A Node.js REST API built with Express, tested using Jest and Supertest, linted with ESLint, and automatically deployed to AWS EC2 using GitHub Actions and Docker.

---

## Architecture Overview

[ Code Push ] ──> [ GitHub Actions CI/CD ] ──> [ Docker Build & Push to ECR ]
│
▼
[ Deploy to AWS EC2 ]


* **Automated CI/CD Pipeline:** Triggers automatically on `push` events to the `main` branch.
* **Testing & Linting:** Code formatting checked with ESLint, pre-commit enforcement via Husky, and unit tests powered by Jest.
* **Automated Deployment:** Builds the Docker container, pushes the image to Amazon ECR, and deploys it directly to the AWS EC2 instance.

---

## Live Endpoints

* **Root Endpoint:** `GET http://51.20.94.40:3000/`[cite: 7]
  * **Response:** ` Deployment Successful! Welcome to the Node.js API.`[cite: 7]
* **Posts Endpoint:** `GET http://51.20.94.40:3000/posts`
  * **Response:** JSON array containing sample post data[cite: 6].

---

## Tech Stack

* **Backend:** Node.js, Express.js
* **Testing Framework:** Jest, Supertest
* **Linting & Quality:** ESLint, Husky
* **CI/CD Platform:** GitHub Actions (`deploy.yml`)[cite: 5]
* **Containerization:** Docker, Amazon ECR
* **Cloud Infrastructure:** AWS EC2

---

## API Documentation

### `GET /`
Returns the server status message[cite: 7].

```bash
curl [http://51.20.94.40:3000/](http://51.20.94.40:3000/)
Response (200 OK):

Plaintext
🚀 Deployment Successful! Welcome to the Node.js API.
GET /posts
Fetches posts data managed by the service controller[cite: 6].

Bash
curl [http://51.20.94.40:3000/posts](http://51.20.94.40:3000/posts)
Response (200 OK):

JSON
[
  {
    "userId": 10,
    "id": 96,
    "title": "quaerat velit veniam amet cupiditate aut numquam ut sequi",
    "body": "in non odio excepturi sint eum\nlabore voluptates vitae quia qui et\ninventore itaque rerum\nveniam non exercitationem delectus aut"
  }
]
Local Development Setup
Prerequisites
Node.js: >=18.x

Package Manager: npm or yarn

Installation & Execution
Clone the repository:

Bash
git clone [https://github.com/AliFaizan-git/CI-CD_Project.git](https://github.com/AliFaizan-git/CI-CD_Project.git)
cd CI-CD_Project
Install dependencies:

Bash
npm install
Run the development server locally:

Bash
npm start
Testing & Quality Assurance
Run Test Suite:

Bash
npm test
Run ESLint Code Fixer:

Bash
npx eslint . --fix
CI/CD Workflow (deploy.yml)
The pipeline runs sequentially on pushes to main[cite: 5]:

build-and-push: Validates code with linter/tests, builds the Docker image, and pushes it to AWS ECR[cite: 5].

deploy-to-ec2: SSHs into the AWS EC2 server, pulls the latest image from ECR, and spins up the updated container[cite: 5].