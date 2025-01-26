module.exports = {
  apps: [
    {
      name: "project-service",
      script: "node",
      args: "dist/index.js",
      cwd: "/home/ubuntu/project-service",
      env: {
        SERVER_HOST: "127.0.0.1",
        SERVER_PORT: "3001",
        DATABASE_USERNAME: "postgres",
        DATABASE_HOST: "127.0.0.1",
        DATABASE_PORT: "5432",
        DATABASE_NAME: "project",
        DATABASE_PASSWORD: "NEW_PASSWORD"
      }
    },
    {
      name: "file-service",
      script: "node",
      args: "index.js",
      cwd: "/home/ubuntu/file-service",
      env: {
        SERVER_HOST: "127.0.0.1",
        SERVER_PORT: "3002",
        DATABASE_USERNAME: "postgres",
        DATABASE_HOST: "127.0.0.1",
        DATABASE_PORT: "5432",
        DATABASE_NAME: "project",
        DATABASE_PASSWORD: "NEW_PASSWORD"
      }
    },
    {
      name: "discord-auth-service",
      script: "node",
      args: "dist/index.js",
      cwd: "/home/ubuntu/discord-auth-service",
      env: {
        SERVER_HOST: "127.0.0.1",
        SERVER_PORT: "3003",
        DISCORD_CLIENT_ID: "YOUR_DISCORD_CLIENT_ID",
        DISCORD_CLIENT_SECRET: "YOUR_DISCORD_CLIENT_SECRET"
      }
    }
  ]
};
