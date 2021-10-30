class JestVimReporter {
  onTestResult(test, results) {
    results.testResults.forEach(test => {
        if (test.status !== 'failed') {
            console.log(`✓ ${test.fullName}`)
            return;
        };

      test.failureMessages.forEach(failureMessage => {
        const msg = failureMessage
          .replace(/\n/g, ' ')
          .replace(/.*?(?=Expected)(.*?)at .*?\((.*?)\).*/, '$1\n($2)')
          .replace(/.*?(?=Error)(.*?)at .*?\((.*?)\).*/, '$1\n($2)')
          .replace(/ +/g, ' ')
          .trim();

        const lines = msg.split('\n');

        if (lines.length !== 2) {
          console.error(
            'JestVimReporter: could not parse error.'
          );

          console.error(failureMessage);
        } else {
          const [line1, line2] = lines;
          const message = line1.trim();
          const location = line2.replace(/^[ ]*\(/, '').replace(/\)[ ]*/, '');

          console.log(`✕ ${test.fullName}`)
          console.log(`${location}: ${message}`);
        }
      });
    });
  }
}

module.exports = JestVimReporter;
