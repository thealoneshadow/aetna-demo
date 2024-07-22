defaultValue={[dayjs('2015/01/01', dateFormat), dayjs('2015/01/01', dateFormat)]}

const currentDate = new Date();

// Get the date from exactly one week ago
const lastWeekDate = new Date();
lastWeekDate.setDate(currentDate.getDate() - 7);

// Format the dates as YYYY-MM-DD
const currentFormattedDate = currentDate.toISOString().slice(0, 10);
const lastWeekFormattedDate = lastWeekDate.toISOString().slice(0, 10);