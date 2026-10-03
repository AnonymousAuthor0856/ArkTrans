// entry/src/main/ets/pages/Index.ets

import { router } from '@kit.ArkUI';

// --- Design Tokens (Converted from AppTokens) ---

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

const COLORS: ColorToken = {
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
};

interface TypographyStyle {
  fontSize: number;
  fontWeight: FontWeight;
}

interface TypographyToken {
  display: TypographyStyle;
  headline: TypographyStyle;
  title: TypographyStyle;
  body: TypographyStyle;
  label: TypographyStyle;
}

const TYPOGRAPHY: TypographyToken = {
  display: { fontSize: 28, fontWeight: FontWeight.Bold },
  headline: { fontSize: 20, fontWeight: FontWeight.Medium },
  title: { fontSize: 16, fontWeight: FontWeight.Medium },
  body: { fontSize: 14, fontWeight: FontWeight.Normal },
  label: { fontSize: 12, fontWeight: FontWeight.Medium }
};

interface ShapeToken {
  small: number;
  medium: number;
  large: number;
}

const SHAPES: ShapeToken = {
  small: 8,
  medium: 12,
  large: 16
};

interface SpacingToken {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
}

const SPACING: SpacingToken = {
  xs: 4,
  sm: 8,
  md: 12,
  lg: 16,
  xl: 24,
  xxl: 36
};

// --- Data Model ---

interface Medicine {
  id: number;
  name: string;
  time: string;
}

// --- Components ---

@Builder
function MedicineItemBuilder(medicine: Medicine) {
  Row() {
    Column() {
      Text(medicine.name)
        .fontColor(COLORS.onSurface)
        .fontSize(TYPOGRAPHY.title.fontSize)
        .fontWeight(TYPOGRAPHY.title.fontWeight)
      
      Text(medicine.time)
        .fontColor(COLORS.onSurface)
        .fontSize(TYPOGRAPHY.body.fontSize)
        .fontWeight(TYPOGRAPHY.body.fontWeight)
        .margin({ top: SPACING.xs })
    }
    
    Blank() // Spacer to push circle to the right
    
    Circle({ width: 16, height: 16 })
      .fill(COLORS.primary)
  }
  .width('100%')
  .padding(SPACING.md)
  .backgroundColor(COLORS.surface)
  .borderRadius(SHAPES.medium)
  .border({ width: 1, color: COLORS.outline, radius: SHAPES.medium })
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
    Stack() {
      // Main Content Area
      Column() {
        // Header
        Text("Medicine Reminder")
          .fontColor(COLORS.onBackground)
          .fontSize(TYPOGRAPHY.display.fontSize)
          .fontWeight(TYPOGRAPHY.display.fontWeight)
          .textAlign(TextAlign.Center)
          .width('100%')
          .margin({ bottom: SPACING.md })

        // List of Medicines
        List({ space: SPACING.md }) {
          ForEach(this.medicines, (medicine: Medicine) => {
            ListItem() {
              MedicineItemBuilder(medicine)
            }
          })
        }
        .width('100%')
        .layoutWeight(1) // Take up remaining space
        
        // Button
        Button("Mark All Taken")
          .type(ButtonType.Capsule)
          .backgroundColor(COLORS.secondary)
          .fontColor(COLORS.onSecondary)
          .fontSize(TYPOGRAPHY.title.fontSize)
          .fontWeight(TYPOGRAPHY.title.fontWeight)
          .width('80%')
          .height(48)
          .margin({ top: SPACING.md, bottom: SPACING.lg })
      }
      .width('100%')
      .height('100%')
      .padding(SPACING.lg)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [[COLORS.surfaceVariant, 0], [COLORS.surface, 1]]
      })

      // Floating Action Button (FAB)
      Button("+")
        .type(ButtonType.Circle)
        .backgroundColor(COLORS.primary)
        .fontColor(COLORS.onPrimary)
        .fontSize(32)
        .fontWeight(FontWeight.Bold)
        .position({ x: 'calc(100% - 60vp)', y: 'calc(100% - 140vp)' }) // Positioned above bottom bar
        .shadow({ radius: 8, color: '#33000000', offsetY: 4 })

      // Bottom Navigation Bar
      Row() {
        Text("Today")
          .fontColor(COLORS.primary)
          .fontSize(TYPOGRAPHY.title.fontSize)
          .fontWeight(TYPOGRAPHY.title.fontWeight)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
        
        Text("History")
          .fontColor(COLORS.onSurface)
          .fontSize(TYPOGRAPHY.title.fontSize)
          .fontWeight(TYPOGRAPHY.title.fontWeight)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
          
        Text("Profile")
          .fontColor(COLORS.onSurface)
          .fontSize(TYPOGRAPHY.title.fontSize)
          .fontWeight(TYPOGRAPHY.title.fontWeight)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(60)
      .backgroundColor(COLORS.surface)
      .align(Alignment.Bottom)
      .shadow({ radius: 8, color: '#1A000000', offsetY: -2 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLORS.background)
  }
}