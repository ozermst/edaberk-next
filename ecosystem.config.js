module.exports = {
  apps: [
    {
      script: "bin/gunicorn_start",
      watch: ".",
    },
  ],
};
