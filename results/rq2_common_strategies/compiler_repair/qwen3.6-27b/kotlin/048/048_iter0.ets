import { Window } from '@kit.ArkUI'

// Token Definitions matching AppTokens
const AppColors = {
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
}

const Spacing = {
  sm: 6,
  md: 10,
  lg: 16,
  xl: 24,
  xxl: 36
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
    Column() {
      // Main Content Area
      Column() {
        Text("Live Shop Events")
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.primary)
          .width('100%')
          .margin({ bottom: Spacing.md })

        List({ space: Spacing.md }) {
          ForEach(this.liveList, (item: LiveItem) => {
            ListItem() {
              this.LiveCardComponent(item)
            }
          })
        }
        .layoutWeight(1)
        .width('100%')
        .padding({ bottom: 96 }) // Space for BottomBar
      }
      .width('100%')
      .height('100%')
      .padding(Spacing.lg)
      .linearGradient({
        angle: 90,
        colors: [['#F5F8FF', 0.0], ['#E8EEFA', 0.5], ['#F5F8FF', 1.0]]
      })

      // Floating Action Button
      Row() {
        Text("+")
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSecondary)
      }
      .width(56)
      .height(56)
      .borderRadius(28)
      .backgroundColor(AppColors.secondary)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .position({ x: 'calc(100% - 72vp)', y: 'calc(100% - 100vp)' })

      // Bottom Navigation Bar
      Row() {
        Text("Home")
          .fontSize(14)
          .fontColor(AppColors.primary)
          .onClick(() => {})
        
        Text("Live")
          .fontSize(14)
          .fontColor(AppColors.onSurface)
          .onClick(() => {})
          
        Text("Cart")
          .fontSize(14)
          .fontColor(AppColors.onSurface)
          .onClick(() => {})
          
        Text("Profile")
          .fontSize(14)
          .fontColor(AppColors.onSurface)
          .onClick(() => {})
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .padding({ left: Spacing.lg, right: Spacing.lg })
      .backgroundColor(AppColors.surface)
      .position({ x: 0, y: 'calc(100% - 56vp)' })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }

  @Builder
  LiveCardComponent(item: LiveItem) {
    Column() {
      // Image Placeholder
      Row()
        .width('100%')
        .height(160)
        .borderRadius(10)
        .backgroundColor(AppColors.secondary)

      Text(item.title)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .margin({ top: Spacing.sm })

      Text(`${item.viewers} viewers`)
        .fontSize(14)
        .fontColor(AppColors.tertiary)
        .margin({ top: 2 })

      Row() {
        Text(item.price)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary)

        Button("Join Live")
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
          .backgroundColor(AppColors.primary)
          .borderRadius(10)
          .margin({ left: 'auto' })
      }
      .width('100%')
      .margin({ top: Spacing.sm })
    }
    .width('100%')
    .padding(Spacing.lg)
    .borderRadius(16)
    .backgroundColor(AppColors.surface)
    .shadow({ radius: 4, color: 'rgba(0,0,0,0.12)', offsetY: 2 })
  }
}