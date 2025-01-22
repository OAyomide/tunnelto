# Build stage
FROM clux/muslrust:stable AS builder

WORKDIR /app
COPY . .

# Build the binary
RUN cargo build --bin tunnelto_server --release

# Final stage
FROM alpine:latest

# Copy the binary from builder
COPY --from=builder /app/target/x86_64-unknown-linux-musl/release/tunnelto_server /tunnelto_server

# Expose required ports
EXPOSE 8080
EXPOSE 5000
EXPOSE 10002

ENTRYPOINT ["/tunnelto_server"]
