// entry/src/main/ets/viewmodel/HabitData.ts

export interface Habit {
  id: number;
  title: string;
  description: string;
  reminderTime?: string; // Format "HH:mm"
  streak: number;
  completed: boolean;
}

export const mockHabits: Habit[] = [
  {
    id: 1,
    title: "Morning Run",
    description: "Run 5km every morning to stay fit",
    reminderTime: "8:00",
    streak: 20,
    completed: false
  },
  {
    id: 2,
    title: "Read 30 Minutes",
    description: "Read technical books before sleep",
    reminderTime: "8:00",
    streak: 24,
    completed: true
  },
  {
    id: 3,
    title: "Meditate",
    description: "Mindfulness meditation to relax",
    streak: 22,
    completed: false
  },
  {
    id: 4,
    title: "Drink 8 Glasses of Water",
    description: "",
    streak: 6,
    completed: true
  },
  {
    id: 5,
    title: "Journal",
    description: "Write down today's events and thoughts",
    reminderTime: "8:00",
    streak: 9,
    completed: true
  },
  {
    id: 6,
    title: "Weekend Hiking",
    description: "Outdoor hiking every Sat & Sun",
    streak: 29,
    completed: true
  }
];