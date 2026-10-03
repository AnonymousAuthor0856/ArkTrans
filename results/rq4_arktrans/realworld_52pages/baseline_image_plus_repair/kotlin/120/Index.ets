// entry/src/main/ets/viewmodel/HabitData.ts

export interface HabitStatus {
  id: number;
  habitId: number;
  date: Date;
}

export interface HabitWithAnalytics {
  title: string;
  consistency: number; // 0 to 1
  currentStreak: number;
  bestStreak: number;
  startedDaysAgo: number;
  statuses: HabitStatus[];
}

// Mock data generator to match the screenshot values
export function getMockHabit(): HabitWithAnalytics {
  return {
    title: "Morning Run",
    consistency: 0.71,
    currentStreak: 27,
    bestStreak: 29,
    startedDaysAgo: 204,
    statuses: generateRandomStatuses()
  };
}

function generateRandomStatuses(): HabitStatus[] {
  const statuses: HabitStatus[] = [];
  const today = new Date();
  for (let i = 0; i < 90; i++) {
    if (Math.random() > 0.3) {
      const d = new Date(today);
      d.setDate(d.getDate() - i);
      statuses.push({ id: i, habitId: 1, date: d });
    }
  }
  return statuses;
}