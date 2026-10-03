// entry/src/main/ets/viewmodel/HabitData.ts

export interface HeatMapData {
  date: string; // Format YYYY-MM-DD
  count: number;
}

export const MOCK_HEATMAP_DATA: HeatMapData[] = [
  // Dec 2025 (Starts on Friday)
  { date: '2025-12-01', count: 3 }, { date: '2025-12-04', count: 2 }, { date: '2025-12-05', count: 4 },
  { date: '2025-12-06', count: 1 }, { date: '2025-12-08', count: 2 }, { date: '2025-12-10', count: 3 },
  { date: '2025-12-11', count: 1 }, { date: '2025-12-12', count: 2 }, { date: '2025-12-13', count: 4 },
  { date: '2025-12-15', count: 1 }, { date: '2025-12-17', count: 3 }, { date: '2025-12-19', count: 2 },
  { date: '2025-12-20', count: 1 }, { date: '2025-12-22', count: 2 }, { date: '2025-12-24', count: 3 },
  { date: '2025-12-26', count: 1 }, { date: '2025-12-27', count: 2 }, { date: '2025-12-29', count: 4 },
  { date: '2025-12-30', count: 1 }, { date: '2025-12-31', count: 2 },

  // Nov 2025 (Starts on Sunday)
  { date: '2025-11-01', count: 1 }, { date: '2025-11-02', count: 2 }, { date: '2025-11-03', count: 3 },
  { date: '2025-11-04', count: 1 }, { date: '2025-11-05', count: 2 }, { date: '2025-11-06', count: 4 },
  { date: '2025-11-07', count: 1 }, { date: '2025-11-08', count: 2 }, { date: '2025-11-09', count: 3 },
  { date: '2025-11-10', count: 1 }, { date: '2025-11-11', count: 2 }, { date: '2025-11-12', count: 4 },
  { date: '2025-11-13', count: 1 }, { date: '2025-11-14', count: 2 }, { date: '2025-11-15', count: 3 },
  { date: '2025-11-16', count: 1 }, { date: '2025-11-17', count: 2 }, { date: '2025-11-18', count: 4 },
  { date: '2025-11-19', count: 1 }, { date: '2025-11-20', count: 2 }, { date: '2025-11-21', count: 3 },
  { date: '2025-11-22', count: 1 }, { date: '2025-11-23', count: 2 }, { date: '2025-11-24', count: 4 },
  { date: '2025-11-25', count: 1 }, { date: '2025-11-26', count: 2 }, { date: '2025-11-27', count: 3 },
  { date: '2025-11-28', count: 1 }, { date: '2025-11-29', count: 2 }, { date: '2025-11-30', count: 4 },

  // Oct 2025 (Starts on Wednesday)
  { date: '2025-10-01', count: 1 }, { date: '2025-10-02', count: 2 }, { date: '2025-10-03', count: 3 },
  { date: '2025-10-04', count: 1 }, { date: '2025-10-05', count: 2 }, { date: '2025-10-06', count: 4 },
  { date: '2025-10-07', count: 1 }, { date: '2025-10-08', count: 2 }, { date: '2025-10-09', count: 3 },
  { date: '2025-10-10', count: 1 }, { date: '2025-10-11', count: 2 }, { date: '2025-10-12', count: 4 },
  { date: '2025-10-13', count: 1 }, { date: '2025-10-14', count: 2 }, { date: '2025-10-15', count: 3 },
  { date: '2025-10-16', count: 1 }, { date: '2025-10-17', count: 2 }, { date: '2025-10-18', count: 4 },
  { date: '2025-10-19', count: 1 }, { date: '2025-10-20', count: 2 }, { date: '2025-10-21', count: 3 },
  { date: '2025-10-22', count: 1 }, { date: '2025-10-23', count: 2 }, { date: '2025-10-24', count: 4 },
  { date: '2025-10-25', count: 1 }, { date: '2025-10-26', count: 2 }, { date: '2025-10-27', count: 3 },
  { date: '2025-10-28', count: 1 }, { date: '2025-10-29', count: 2 }, { date: '2025-10-30', count: 4 },
  { date: '2025-10-31', count: 1 },

  // Sep 2025 (Starts on Monday)
  { date: '2025-09-01', count: 1 }, { date: '2025-09-02', count: 2 }, { date: '2025-09-03', count: 3 },
  { date: '2025-09-04', count: 1 }, { date: '2025-09-05', count: 2 }, { date: '2025-09-06', count: 4 },
  { date: '2025-09-07', count: 1 }, { date: '2025-09-08', count: 2 }, { date: '2025-09-09', count: 3 },
  { date: '2025-09-10', count: 1 }, { date: '2025-09-11', count: 2 }, { date: '2025-09-12', count: 4 },
  { date: '2025-09-13', count: 1 }, { date: '2025-09-14', count: 2 }, { date: '2025-09-15', count: 3 },
  { date: '2025-09-16', count: 1 }, { date: '2025-09-17', count: 2 }, { date: '2025-09-18', count: 4 },
  { date: '2025-09-19', count: 1 }, { date: '2025-09-20', count: 2 }, { date: '2025-09-21', count: 3 },
  { date: '2025-09-22', count: 1 }, { date: '2025-09-23', count: 2 }, { date: '2025-09-24', count: 4 },
  { date: '2025-09-25', count: 1 }, { date: '2025-09-26', count: 2 }, { date: '2025-09-27', count: 3 },
  { date: '2025-09-28', count: 1 }, { date: '2025-09-29', count: 2 }, { date: '2025-09-30', count: 4 },
];

// Helper to get color based on intensity
export function getHeatmapColor(count: number): string {
  if (count === 0) return '#FFFFFF'; // White/Empty
  if (count === 1) return '#E8DFF5'; // Lightest Purple
  if (count === 2) return '#CDB5E8'; // Light Purple
  if (count === 3) return '#A388CC'; // Medium Purple
  return '#6B4C9A'; // Dark Purple
}