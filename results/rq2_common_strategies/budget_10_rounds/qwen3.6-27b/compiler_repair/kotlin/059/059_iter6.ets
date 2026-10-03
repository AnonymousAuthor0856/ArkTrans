import { window } from '@kit.ArkUI';

// --- App Tokens & Constants ---

interface AppColors {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  success: string;
  warning: string;
  error: string;
  onPrimary: string;
  onSecondary: string;
  onTertiary: string;
  onBackground: string;
  onSurface: string;
}

interface AppSpacing {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
}

const AppTokens = {
  Colors: {
    primary: '#111827',
    secondary: '#374151',
    tertiary: '#6B7280',
    background: '#F9FAFB',
    surface: '#FFFFFF',
    surfaceVariant: '#E5E7EB',
    outline: '#D1D5DB',
    success: '#16A34A',
    warning: '#F59E0B',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onSecondary: '#FFFFFF',
    onTertiary: '#111827',
    onBackground: '#111827',
    onSurface: '#1F2937'
  } as AppColors,
  Spacing: {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 36
  } as AppSpacing
};

interface Medicine {
  id: number;
  name: string;
  time: string;
}

@Entry
@Component
struct RootScreen {
  @State medicines: Medicine[] = [
    { id: 1, name: "Vitamin C", time: "08:00 AM" },
    { id: 2, name: "Aspirin", time: "12:30 PM" },
    { id: 3, name: "Insulin", time: "06:00 PM" },
    { id: 4, name: "Melatonin", time: "10:00 PM" }
  ];

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        // Header
        Text("Medicine Reminder")
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onBackground)
          .margin({ bottom: AppTokens.Spacing.md })

        // List
        LazyColumn({ space: AppTokens.Spacing.md }) {
          ForEach(this.medicines, (item: Medicine) => {
            MedicineItem({ medicine: item })
          })
        }
        .layoutWeight(1)
        .padding({ bottom: AppTokens.Spacing.xxl })

        // Spacer before button
        Blank()
          .height(AppTokens.Spacing.md)

        // Button
        Button("Mark All Taken")
          .width('80%')
          .height(48)
          .backgroundColor(AppTokens.Colors.secondary)
          .fontColor(AppTokens.Colors.onSecondary)
          .borderRadius(16)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .onClick(() => {
            // Action
          })
      }
      .width('100%')
      .height('100%')
      .padding(AppTokens.Spacing.lg)
      .linearGradient({
        angle: 90,
        colors: [['#E5E7EB', 0], ['#FFFFFF', 1]]
      })

      // Floating Action Button
      Row() {
        Text("+")
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onPrimary)
      }
      .width(56)
      .height(56)
      .borderRadius(28)
      .backgroundColor(AppTokens.Colors.primary)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .position({ x: 'auto', y: 'auto' }) // Positioned by Stack alignment
      .margin({ right: AppTokens.Spacing.lg, bottom: 80 }) // Offset for BottomBar height + padding

      // Bottom Bar
      Row() {
        Text("Today")
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.primary)
        
        Text("History")
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
        
        Text("Profile")
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(60)
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppTokens.Colors.surface)
      .shadow({ radius: 8, color: 'rgba(0,0,0,0.14)', offsetY: 4 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

@Component
struct MedicineItem {
  @Prop medicine: Medicine;

  aboutToAppear(): void {
    // Initialization if needed, but prop is set via constructor args in ArkTS usually or default value
  }

  build() {
    Row() {
      Column() {
        Text(this.medicine.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
        
        Text(this.medicine.time)
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ top: AppTokens.Spacing.xs })
      }

      Circle({ width: 16, height: 16 })
        .fill(AppTokens.Colors.primary)
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(12)
    .border({ width: 1, color: AppTokens.Colors.outline, radius: 12 })
  }
}