module.exports = {
  ci: {
    collect: {
      staticDistDir: './docs',
      url: ['/index.html', '/quiz.html'],
      numberOfRuns: 1,
      settings: {
        chromeFlags: '--no-sandbox --disable-dev-shm-usage',
      },
    },
  },
};
