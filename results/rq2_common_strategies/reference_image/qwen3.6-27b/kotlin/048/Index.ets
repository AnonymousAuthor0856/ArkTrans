import { window } from '@kit.ArkUI';

// --- App Tokens & Constants ---

const NAME = "063*LiveShop*en";
const UI_TYPE = "ECommerce";
const STYLE_THEME = "Modern Blue";
const LANG = "en";
const BASELINE_SIZE = "720x1280";

class AppTokens {
  static Colors = {
    primary: '#1E3A8A',
    secondary: '#3B82F6',
    tertiary: '#60A5FA',
    background: '#F5F8FF',
    surface: '#FFFFFF',
    surfaceVariant: '#E8EEFA',
    outline: '#CBD5E1',
    success: '#22C55E',
    warning: '#F59E0B',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onSecondary: '#FFFFFF',
    onTertiary: '#0B1220',
    onBackground: '#0B1220',
    onSurface: '#0B1220'
  };

  static TypographyTokens = {
    display: { fontSize: 28, fontWeight: FontWeight.Bold },
    title: { fontSize: 18, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium }
  };

  static Shapes = {
    small: 6,
    medium: 10,
    large: 16
  };

  static Spacing = {
    sm: 6,
    md: 10,
    lg: 16,
    xl: 24,
    xxl: 36
  };

  static ElevationMapping = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.12 },
    level2: { elevation: 6, radius: 8, dy: 4, opacity: 0.15 },
    level3: { elevation: 10, radius: 12, dy: 6, opacity: 0.18 }
  };
}

interface LiveItem {
  id: number;
  title: string;
  viewers: number;
  price: string;
}

@Entry
@Component
struct RootScreen {
  @State liveList: LiveItem[] = [
    { id: 1, title: "Smartphone Flash Deal", viewers: 1234, price: "$699" },
    { id: 2, title: "Gaming Chair Special", viewers: 880, price: "$249" },
    { id: 3, title: "Headphones Clearance", viewers: 1640, price: "$99" },
    { id: 4, title: "Mechanical Keyboard", viewers: 512, price: "$129" }
  ];

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        // Main Content Area
        Column() {
          Text("Live Shop Events")
            .fontStyle(AppTokens.TypographyTokens.display)
            .fontColor(AppTokens.Colors.primary)
            .width('100%')
            .textAlign(TextAlign.Start)
            .margin({ bottom: AppTokens.Spacing.md })

          List({ space: AppTokens.Spacing.md }) {
            ForEach(this.liveList, (item: LiveItem) => {
              ListItem() {
                this.LiveCard(item)
              }
            }, (item: LiveItem) => item.id.toString())
          }
          .layoutWeight(1)
          .width('100%')
          .padding({ bottom: 96 }) // Space for BottomBar
        }
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)
        .linearGradient({
          direction: GradientDirection.Bottom,
          colors: [
            [AppTokens.Colors.background, 0],
            [AppTokens.Colors.surfaceVariant, 0.5],
            [AppTokens.Colors.background, 1]
          ]
        })
        .padding(AppTokens.Spacing.lg)
      }

      // Floating Action Button
      Button('+', { type: ButtonType.Circle })
        .width(56)
        .height(56)
        .fontSize(24)
        .fontColor(AppTokens.Colors.onSecondary)
        .backgroundColor(AppTokens.Colors.secondary)
        .shadow({
          radius: AppTokens.ElevationMapping.level2.radius,
          color: 'rgba(0, 0, 0, 0.15)',
          offsetX: 0,
          offsetY: AppTokens.ElevationMapping.level2.dy
        })
        .position({ x: 'calc(100% - 40px)', y: 'calc(100% - 100px)' })

      // Bottom Navigation Bar
      Row() {
        Text("Home")
          .fontStyle(AppTokens.TypographyTokens.body)
          .fontColor(AppTokens.Colors.primary)
          .onClick(() => {})
        
        Text("Live")
          .fontStyle(AppTokens.TypographyTokens.body)
          .fontColor(AppTokens.Colors.onSurface)
          .onClick(() => {})
          
        Text("Cart")
          .fontStyle(AppTokens.TypographyTokens.body)
          .fontColor(AppTokens.Colors.onSurface)
          .onClick(() => {})
          
        Text("Profile")
          .fontStyle(AppTokens.TypographyTokens.body)
          .fontColor(AppTokens.Colors.onSurface)
          .onClick(() => {})
      }
      .width('100%')
      .height(60)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
      .backgroundColor(AppTokens.Colors.surface)
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  LiveCard(item: LiveItem) {
    Column() {
      // Image Placeholder
      Row()
        .width('100%')
        .height(160)
        .borderRadius(AppTokens.Shapes.medium)
        .backgroundColor(AppTokens.Colors.secondary)
      
      Text(item.title)
        .fontStyle(AppTokens.TypographyTokens.title)
        .fontColor(AppTokens.Colors.onSurface)
        .margin({ top: AppTokens.Spacing.sm })
        
      Text(`${item.viewers} viewers`)
        .fontStyle(AppTokens.TypographyTokens.body)
        .fontColor(AppTokens.Colors.tertiary)
        .margin({ top: AppTokens.Spacing.sm })
        
      Row() {
        Text(item.price)
          .fontStyle(AppTokens.TypographyTokens.title)
          .fontColor(AppTokens.Colors.primary)
          
        Blank()
          
        Button("Join Live")
          .fontStyle(AppTokens.TypographyTokens.label)
          .fontColor(AppTokens.Colors.onPrimary)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.medium)
          .height(40)
          .onClick(() => {})
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .margin({ top: AppTokens.Spacing.sm })
    }
    .width('100%')
    .padding(AppTokens.Spacing.lg)
    .borderRadius(AppTokens.Shapes.large)
    .backgroundColor(AppTokens.Colors.surface)
    .shadow({
      radius: AppTokens.ElevationMapping.level1.radius,
      color: 'rgba(0, 0, 0, 0.12)',
      offsetX: 0,
      offsetY: AppTokens.ElevationMapping.level1.dy
    })
  }
}