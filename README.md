# spring-monitored
Spring Boot service with logging and metrics. Will probably use this as a base for other services if metrics are needed.

Logs, metrics and traces are collected via the [OpenTelemetry agent](https://opentelemetry.io/docs/zero-code/java/agent/) (see [Dockerfile](Dockerfile)).
This is achieved by dynamically injecting bytecode when the spring-monitored service is running in the JVM.

They are then shipped over to the datadog agent, which is running in a separate container. This container then sends them
to the hosted DataDog application, allowing the logs, metrics and traces to be viewable in the UI.

![You can see the resulting APM for the service below](DD.png)
