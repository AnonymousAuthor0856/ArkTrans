// entry/src/main/ets/viewmodel/HabitData.ts

export interface HabitStatus {
  id: number;
  habitId: number;
  date: Date;
}

export interface HabitWithAnalytics {
  title: string;
  statuses: HabitStatus[];
}

/**
 * Mock data generator to match the visual state of the screenshot.
 * The screenshot shows Feb and March 2026.
 */
export function getMockCalendarData(): HabitWithAnalytics {
  const today = new Date(2026, 2, 17); // March 17, 2026
  
  // Generate some random completed dates for visual effect (optional)
  // For this specific screenshot reproduction, we will leave them empty 
  // or add a few to show the "completed" style if needed.
  // The screenshot provided actually looks like all days are uncompleted (white circles).
  
  return {
    title: "Morning Run",
    statuses: [] 
  };
}