import { BusinessError } from '@kit.BasicServicesKit';

// MARK: - AppTokens
// 翻译自 Kotlin 的 AppTokens 对象，用于定义颜色、字体、形状、间距和阴影。

interface ColorToken {
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

interface TypographyToken {
  size: number;
  weight: FontWeight;
}

interface TypographyTokens {
  displayLarge: TypographyToken;
  headlineMedium: TypographyToken;
  titleMedium: TypographyToken;
  bodyMedium: TypographyToken;
  labelMedium: TypographyToken;
}

interface ShapeToken {
  small: number;
  medium: number;
  large: number;
}

interface SpacingToken {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
}

class ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation;
    this.radius = radius;
    this.dy = dy;
    this.opacity = opacity;
  }
}

interface ElevationMapping {
  level1: ShadowSpec;
  level2: ShadowSpec;
  level3: ShadowSpec;
}

class AppTokens {
  static Colors: ColorToken = {
    // 将 Kotlin 的 Color(0xFF...) 转换为 ArkTS 的 '#RRGGBB' 或 'rgba(r,g,b,a)'
    primary: '#111827', // 0xFF111827
    secondary: '#374151', // 0xFF374151
    tertiary: '#6B7280', // 0xFF6B7280
    background: '#F9FAFB', // 0xFFF9FAFB
    surface: '#FFFFFF', // 0xFFFFFFFF
    surfaceVariant: '#E5E7EB', // 0xFFE5E7EB
    outline: '#D1D5DB', // 0xFFD1D5DB
    success: '#16A34A', // 0xFF16A34A
    warning: '#F59E0B', // 0xFFF59E0B
    error: '#EF4444', // 0xFFEF4444
    onPrimary: '#FFFFFF', // 0xFFFFFFFF
    onSecondary: '#FFFFFF', // 0xFFFFFFFF
    onTertiary: '#111827', // 0xFF111827
    onBackground: '#111827', // 0xFF111827
    onSurface: '#1F2937' // 0xFF1F2937
  };

  static TypographyTokens: TypographyTokens = {
    // Compose 的 sp 单位直接映射为 ArkTS 的 FontSize (vp)
    displayLarge: { size: 28, weight: FontWeight.Bold },
    headlineMedium: { size: 20, weight: FontWeight.Medium }, // SemiBold not supported, using Medium
    titleMedium: { size: 16, weight: FontWeight.Medium },
    bodyMedium: { size: 14, weight: FontWeight.Normal },
    labelMedium: { size: 12, weight: FontWeight.Medium }
  };

  static Shapes: ShapeToken = {
    // Compose 的 dp 单位直接映射为 ArkTS 的 vp
    small: 8.0,
    medium: 12.0,
    large: 16.0
  };

  static Spacing: SpacingToken = {
    // Compose 的 dp 单位直接映射为 ArkTS 的 vp
    xs: 4.0,
    sm: 8.0,
    md: 12.0,
    lg: 16.0,
    xl: 24.0,
    xxl: 36.0
  };

  static ElevationMapping: ElevationMapping = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.12 },
    level2: { elevation: 4, radius: 8, dy: 4, opacity: 0.14 },
    level3: { elevation: 8, radius: 12, dy: 6, opacity: 0.16 }
  };
}

// MARK: - Data Model
// 翻译自 Kotlin 的 data class Medicine
interface Medicine {
  id: number;
  name: string;
  time: string;
}

// MARK: - MedicineItem View
// 翻译自 Kotlin 的 @Composable fun MedicineItem
@Component
struct MedicineItem {
  medicine: Medicine = { id: 0, name: '', time: '' };

  build() {
    Row() {
      Column() {
        Text(this.medicine.name)
          .fontSize(AppTokens.TypographyTokens.titleMedium.size)
          .fontWeight(AppTokens.TypographyTokens.titleMedium.weight)
          .fontColor(AppTokens.Colors.onSurface)
        
        Text(this.medicine.time)
          .margin({ top: AppTokens.Spacing.xs })
          .fontSize(AppTokens.TypographyTokens.bodyMedium.size)
          .fontWeight(AppTokens.TypographyTokens.bodyMedium.weight)
          .fontColor(AppTokens.Colors.onSurface)
      }
      
      Blank() // Spacer
      
      Circle()
        .width(16)
        .height(16)
        .fill(AppTokens.Colors.primary)
    }
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
    .border({ width: 1, color: AppTokens.Colors.outline, radius: AppTokens.Shapes.medium })
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }
}

// MARK: - MedicineList View
// 翻译自 Kotlin 的 @Composable fun MedicineList
@Component
struct MedicineList {
  items: Medicine[] = [
    { id: 1, name: "Vitamin C", time: "08:00 AM" },
    { id: 2, name: "Aspirin", time: "12:30 PM" },
    { id: 3, name: "Insulin", time: "06:00 PM" },
    { id: 4, name: "Melatonin", time: "10:00 PM" }
  ];

  build() {
    Scroll() {
      Column() {
        ForEach(this.items, (medicine: Medicine) => {
          MedicineItem({ medicine: medicine })
            .margin({ bottom: AppTokens.Spacing.md })
        }, (medicine: Medicine) => medicine.id.toString())
        
        // Padding at the bottom of the list content
        Blank().height(AppTokens.Spacing.xxl)
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .scrollBar(BarState.Off)
  }
}

// MARK: - RootScreen View
// 翻译自 Kotlin 的 @Composable fun RootScreen
@Component
struct RootScreen {
  build() {
    Stack() {
      // Main Content Area
      Column() {
        // Top Section with Title and List
        Column() {
          Text("Medicine Reminder")
            .fontSize(AppTokens.TypographyTokens.displayLarge.size)
            .fontWeight(AppTokens.TypographyTokens.displayLarge.weight)
            .fontColor(AppTokens.Colors.onBackground)
            .margin({ bottom: AppTokens.Spacing.md })

          MedicineList()
            .layoutWeight(1) // Pushes button to bottom

          Button({ type: ButtonType.Capsule, stateEffect: true }) {
            Text("Mark All Taken")
              .fontSize(AppTokens.TypographyTokens.titleMedium.size)
              .fontWeight(AppTokens.TypographyTokens.titleMedium.weight)
              .fontColor(AppTokens.Colors.onSecondary)
          }
          .height(48)
          .width('100%')
          .backgroundColor(AppTokens.Colors.secondary)
          .borderRadius(AppTokens.Shapes.large)
          .margin({ 
            left: 10, // Approximation of 10% padding relative to parent content area
            right: 10, 
            bottom: AppTokens.Spacing.md 
          })
        }
        .padding({ 
          top: AppTokens.Spacing.lg, 
          left: AppTokens.Spacing.lg, 
          right: AppTokens.Spacing.lg 
        })
        .linearGradient({
          angle: 90,
          colors: [[AppTokens.Colors.surfaceVariant, 0], [AppTokens.Colors.surface, 1]]
        })
        .width('100%')
        .layoutWeight(1)
        .padding({ bottom: 56 }) // Reserve space for BottomAppBar
      }
      .backgroundColor(AppTokens.Colors.background)
      .width('100%')
      .height('100%')

      // BottomAppBar
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
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
      .width('100%')
      .height(56)
      .backgroundColor(AppTokens.Colors.surface)
      .shadow({
        radius: AppTokens.ElevationMapping.level2.radius,
        color: `rgba(0, 0, 0, ${AppTokens.ElevationMapping.level2.opacity})`,
        offsetX: 0,
        offsetY: AppTokens.ElevationMapping.level2.dy
      })
      .position({ x: 0, y: '100%' })
      .translate({ y: -56 }) // Move up by its height

      // FloatingActionButton
      Button({ type: ButtonType.Circle, stateEffect: true }) {
        Text("+")
          .fontSize(AppTokens.TypographyTokens.displayLarge.size)
          .fontWeight(AppTokens.TypographyTokens.displayLarge.weight)
          .fontColor(AppTokens.Colors.onPrimary)
      }
      .width(56)
      .height(56)
      .backgroundColor(AppTokens.Colors.primary)
      .borderRadius(28) // Circle shape
      .position({ x: '100%', y: '100%' })
      .translate({ x: -56 - AppTokens.Spacing.lg, y: -56 - AppTokens.Spacing.lg }) // Position with padding
    }
    .width('100%')
    .height('100%')
  }
}

// MARK: - App Entry Point
@Entry
@Component
struct MedicineReminderApp {
  build() {
    Column() {
      RootScreen()
    }
  }
}