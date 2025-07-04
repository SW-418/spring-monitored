plugins {
	java
	id("org.springframework.boot") version "3.5.3"
	id("io.spring.dependency-management") version "1.1.7"
}

group = "io.samwells"
version = "1.0.0"

java {
	toolchain {
		languageVersion = JavaLanguageVersion.of(21)
	}
}

configurations {
	all {
		exclude(module = "spring-boot-starter-logging")
	}
}

repositories {
	mavenCentral()
}

dependencies {
	implementation("org.springframework.boot:spring-boot-starter-actuator")
	implementation("org.springframework.boot:spring-boot-starter-web")

	// SLF4J (Simple Logging Facade for Java) API - Allows usage of generic API
	// regardless of uderlying logging implementation
	implementation("org.slf4j:slf4j-api:2.0.17")
	// Acts as a bridge between SLF4J and Log4j
	implementation("org.apache.logging.log4j:log4j-slf4j2-impl:2.25.0")
	// Core logic for the Log4j2 logging framework
	implementation("org.apache.logging.log4j:log4j-core:2.25.0")

	testImplementation("org.springframework.boot:spring-boot-starter-test")
	testRuntimeOnly("org.junit.platform:junit-platform-launcher")
}

tasks.withType<Test> {
	useJUnitPlatform()
}
