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
EXPOSE 8080  # client svc
EXPOSE 5000  # ctrl svc
EXPOSE 10002 # net svc

ENTRYPOINT ["/tunnelto_server"]
