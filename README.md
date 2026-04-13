# Prometheus and Grafana Monitoring Stack

This project is an experimental setup to learn and apply Prometheus and Grafana for monitoring systems, processes, and containers. It provides a minimal configuration to get started with a monitoring stack using Docker Compose, and can be extended for more dynamic deployments using tools like Helm charts, Ansible, or others for cross-machine setups.

## Overview

The monitoring stack includes:
- **Prometheus**: Time-series database for metrics collection and alerting.
- **Grafana**: Visualization and dashboarding tool.
- **Alertmanager**: Handles alerts from Prometheus.
- **Exporters**: Node Exporter (for system metrics), Process Exporter (for specific processes), and cAdvisor (for container metrics).

The setup uses Docker Compose for local deployment and includes scripts to deploy as systemd services on Linux systems.

## Architecture

- **Prometheus** scrapes metrics from exporters and evaluates alert rules.
- **Exporters** collect metrics from the host system, processes, and containers.
- **Grafana** connects to Prometheus as a datasource and displays pre-configured dashboards.
- **Alertmanager** sends notifications (configured for email in this setup).

## Prerequisites

- Docker and Docker Compose installed on the system.
- For deployment scripts: sudo access to manage systemd services.

## Installation and Setup

### Quick Start with Docker Compose

1. Clone or navigate to the project directory.
2. Run the checks script to ensure Docker and Docker Compose are installed:
   ```bash
   ./scripts/checks.sh
   ```
3. Start the main stack (Prometheus, Grafana, Alertmanager):
   ```bash
   docker compose up -d
   ```
4. Start the exporters:
   ```bash
   cd exporters
   docker compose up -d
   ```

### Deploy as Systemd Services

Use the provided scripts to deploy the stack and exporters as systemd services for automatic startup.

1. Deploy the main stack:
   ```bash
   ./scripts/deploy_prometheus.bash
   ```
2. Deploy the exporters:
   ```bash
   ./scripts/deploy_exporter.bash
   ```

These scripts create systemd service files and enable/start them.

## Configuration

### Prometheus

- **prometheus.yml**: Main configuration with scrape jobs for Prometheus itself, node_exporter, process_exporter, and container_exporter. Includes alerting configuration.
- **alert-rules.yml**: Sample alert rules for monitoring 'yes' processes (high count and CPU usage).
- **targets/**: dynamic JSON files defining targets for exporters (node.json, process.json, container.json).

### Alertmanager

- **alertmanager.yml**: Configured to send alerts via email (still a placeholder)

### Grafana

- **provisioning/datasources/datasource.yml**: Configures Prometheus as the default datasource.
- **provisioning/dashboards/dashboards.yml**: Sets up dashboard provisioning from the dashboards directory.
- **dashboards/**: Pre-built dashboards for containers (containers-dashboard.json) and processes (processes-dashboard.json).

### Exporters

- **exporters/docker-compose.yml**: Defines services for node_exporter, process_exporter, and cAdvisor.
- **process_exporter/process-exporter.yml**: Configures which processes to monitor (e.g., 'yes', 'psql', 'sleep').

## Usage

- **Prometheus UI**: Access at http://localhost:9090
- **Grafana UI**: Access at http://localhost:3000 (default login: admin/admin)
- **Alertmanager UI**: Access at http://localhost:9093

In Grafana, the dashboards should be automatically provisioned. You can view metrics for system load, container CPU/memory, and specific processes.

## Future Enhancements

This setup is minimal and can be expanded:
- **Ansible**: Automate deployment across multiple machines.
- **Additional Exporters**: Add more exporters for databases, applications, etc.
- **Alerting**: Configuring and Securing alert manager credentials.