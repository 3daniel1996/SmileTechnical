# Flask Hello Smile API

## Description

This project is a simple Flask API that responds with a JSON message saying "Hello Smile" when accessed.

## Table of Contents

- [Software Prerequisites](#software-prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [API Documentation](#api-documentation)
- [Contributing](#contributing)
- [License](#license)

## Software Prerequisites

Before running this Flask API locally, ensure you have the following software installed on your machine:

- [Git](https://git-scm.com/)
- [Docker](https://www.docker.com/)
- [Python](https://www.python.org/) (if not included in your Docker image)

## Installation

To run this Flask API locally, follow these steps:

1. **Clone the repository:**
    ```bash
    git clone https://github.com/your-username/your-repository.git
    cd your-repository
    ```

2. **Build the Docker image:**
    ```bash
    docker build -t flask-app .
    ```

3. **Run the Docker container:**
    ```bash
    docker run -p 5000:5000 flask-app
    ```

## Usage

The API responds with a JSON message when accessed. Follow the steps in the [Installation](#installation) section to run the API locally using Docker. Once the Docker container is running, you can access the API at `http://localhost:5000/` using your web browser or a tool like [Postman](https://www.postman.com/).

### Example Endpoint

- **Endpoint:** `/`
- **Method:** GET
- **Description:** Returns a JSON message saying "Hello Smile."
- **Request:**
  - Method: GET
- **Response:**
  - Status: 200 OK
  - Body: `{ "message": "Hello Smile" }`