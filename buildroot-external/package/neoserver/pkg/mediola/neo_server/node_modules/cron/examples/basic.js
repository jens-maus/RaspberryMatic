const CronJob = require('../lib/cron.js').CronJob;

console.log('Before job instantiation');
const job = new CronJob('* * 7-23 * * *', function() {
	const d = new Date();
	console.log('Every second:', d);
});
console.log('After job instantiation');
job.start();
