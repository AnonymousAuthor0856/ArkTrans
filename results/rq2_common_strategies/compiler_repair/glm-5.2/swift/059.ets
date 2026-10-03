// AppTokens.ets
interface ColorsType {
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

interface TypographyType {
  size: number;
  weight: FontWeight;
}

interface TypographyTokensType {
  displayLarge: TypographyType;
  headlineMedium: TypographyType;
  titleMedium: TypographyType;
  bodyMedium: TypographyType;
  labelMedium: TypographyType;
}

interface ShapesType {
  small: number;
  medium: number;
  large: number;
}

interface SpacingType {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
}

interface ShadowSpecType {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;
}

interface ElevationMappingType {
  level1: ShadowSpecType;
  level2: ShadowSpecType;
  level3: ShadowSpecType;
}

export class AppTokens {
  static Colors: ColorsType = {
    primary: '#FF111827',
    secondary: '#FF374151',
    tertiary: '#FF6B7280',
    background: '#FFF9FAFB',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFE5E7EB',
    outline: '#FFD1D5DB',
    success: '#FF16A34A',
    warning: '#FFF59E0B',
    error: '#FFEF4444',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FFFFFFFF',
    onTertiary: '#FF111827',
    onBackground: '#FF111827',
    onSurface: '#FF1F2937'
  }

  static TypographyTokens: TypographyTokensType = {
    displayLarge: { size: 28, weight: FontWeight.Bold } as TypographyType,
    headlineMedium: { size: 20, weight: FontWeight.Medium } as TypographyType,
    titleMedium: { size: 16, weight: FontWeight.Medium } as TypographyType,
    bodyMedium: { size: 14, weight: FontWeight.Normal } as TypographyType,
    labelMedium: { size: 12, weight: FontWeight.Medium } as TypographyType
  }

  static Shapes: ShapesType = {
    small: 8,
    medium: 12,
    large: 16
  }

  static Spacing: SpacingType = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 36
  }

  static ElevationMapping: ElevationMappingType = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.12 } as ShadowSpecType,
    level2: { elevation: 4, radius: 8, dy: 4, opacity: 0.14 } as ShadowSpecType,
    level3: { elevation: 8, radius: 12, dy: 6, opacity: 0.16 } as ShadowSpecType
  }
}

// Data Model
export interface Medicine {
  id: number;
  name: string;
  time: string;
}

// MedicineItem Component
@Component
export struct MedicineItem {
  @Prop medicine: Medicine;

  build() {
    Row() {
      Column() {
        Text(this.medicine.name)
          .fontSize(AppTokens.TypographyTokens.titleMedium.size)
          .fontWeight(AppTokens.TypographyTokens.titleMedium.weight)
          .fontColor(AppTokens.Colors.onSurface)
        
        Text(this.medicine.time)
          .fontSize(AppTokens.TypographyTokens.bodyMedium.size)
          .fontWeight(AppTokens.TypographyTokens.bodyMedium.weight)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ top: AppTokens.Spacing.xs })
      }
      .alignItems(HorizontalAlign.Start)

      Blank() // Pushes the circle to the right

      Circle({ width: 16, height: 16 })
        .fill(AppTokens.Colors.primary)
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
    .border({ width: 1, color: AppTokens.Colors.outline, radius: AppTokens.Shapes.medium })
  }
}

// MedicineList Component
@Component
export struct MedicineList {
  private items: Medicine[] = [
    { id: 1, name: "Vitamin C", time: "08:00 AM" } as Medicine,
    { id: 2, name: "Aspirin", time: "12:30 PM" } as Medicine,
    { id: 3, name: "Insulin", time: "06:00 PM" } as Medicine,
    { id: 4, name: "Melatonin", time: "10:00 PM" } as Medicine
  ];

  build() {
    Scroll() {
      Column({ space: AppTokens.Spacing.md }) {
        ForEach(this.items, (item: Medicine) => {
          MedicineItem({ medicine: item })
        })
      }
      .padding({ bottom: AppTokens.Spacing.xxl })
    }
    .scrollBar(BarState.Off)
    .width('100%')
    .layoutWeight(1) // Allows the list to fill available space
  }
}

// RootScreen Component
@Entry
@Component
struct RootScreen {
  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      // Main Content Area
      Column() {
        // Top Section with Gradient
        Column() {
          Text("Medicine Reminder")
            .fontSize(AppTokens.TypographyTokens.displayLarge.size)
            .fontWeight(AppTokens.TypographyTokens.displayLarge.weight)
            .fontColor(AppTokens.Colors.onBackground)

          MedicineList()

          Button("Mark All Taken")
            .fontSize(AppTokens.TypographyTokens.titleMedium.size)
            .fontWeight(AppTokens.TypographyTokens.titleMedium.weight)
            .fontColor(AppTokens.Colors.onSecondary)
            .height(48)
            .width('80%')
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(AppTokens.Shapes.large)
            .margin({ bottom: AppTokens.Spacing.md })
        }
        .width('100%')
        .height('100%')
        .padding({ top: AppTokens.Spacing.lg, left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
        .linearGradient({
          angle: 180,
          colors: [[AppTokens.Colors.surfaceVariant, 0.0], [AppTokens.Colors.surface, 1.0]]
        })
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppTokens.Colors.background)

      // Bottom App Bar
      Column() {
        Blank() // Pushes the bar to the bottom
        
        Row() {
          Text("Today")
            .fontSize(AppTokens.TypographyTokens.titleMedium.size)
            .fontWeight(AppTokens.TypographyTokens.titleMedium.weight)
            .fontColor(AppTokens.Colors.primary)
          
          Blank()
          
          Text("History")
            .fontSize(AppTokens.TypographyTokens.titleMedium.size)
            .fontWeight(AppTokens.TypographyTokens.titleMedium.weight)
            .fontColor(AppTokens.Colors.onSurface)
            
          Blank()
          
          Text("Profile")
            .fontSize(AppTokens.TypographyTokens.titleMedium.size)
            .fontWeight(AppTokens.TypographyTokens.titleMedium.weight)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .width('100%')
        .height(56)
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
        .backgroundColor(AppTokens.Colors.surface)
        .shadow({
          radius: AppTokens.ElevationMapping.level2.radius,
          color: `rgba(0,0,0,${AppTokens.ElevationMapping.level2.opacity})`,
          offsetY: AppTokens.ElevationMapping.level2.dy
        })
      }
      .width('100%')
      .height('100%')

      // Floating Action Button
      Button('+')
        .fontSize(AppTokens.TypographyTokens.displayLarge.size)
        .fontWeight(AppTokens.TypographyTokens.displayLarge.weight)
        .fontColor(AppTokens.Colors.onPrimary)
        .width(56)
        .height(56)
        .borderRadius(28) // Circle
        .backgroundColor(AppTokens.Colors.primary)
        .margin(AppTokens.Spacing.lg)
    }
    .width('100%')
    .height('100%')
  }
}