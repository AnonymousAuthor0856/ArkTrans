// entry/src/main/ets/viewpages/MainPage.ets

@Entry
@Component
struct WorkoutPlanApp {
  // AppTokens equivalent constants
  private readonly primaryColor: ResourceColor = '#2563EB'
  private readonly secondaryColor: ResourceColor = '#38BDF8'
  private readonly surfaceColor: ResourceColor = '#FFFFFF'
  private readonly outlineColor: ResourceColor = '#CBD5E1'
  private readonly textColorPrimary: ResourceColor = '#0F172A'
  private readonly textColorSecondary: ResourceColor = '#1E293B'
  
  @State selectedTab: string = 'Home'

  build() {
    Column() {
      // Top Bar
      Row() {
        Text('Workout Plan')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.textColorPrimary)
      }
      .width('100%')
      .height(64)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(this.surfaceColor)

      // Main Content Area
      Column() {
        Text('Sign In to Continue')
          .fontSize(20)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(this.textColorSecondary)
          .margin({ top: 16, bottom: 16 })

        // Workout Preview Box
        Column() {
          Text('Workout Preview')
            .fontSize(14)
            .fontColor(this.textColorSecondary)
        }
        .width('100%')
        .height(200)
        .backgroundColor(this.surfaceColor)
        .borderWidth(1)
        .borderColor(this.outlineColor)
        .borderRadius(16)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)

        // Authenticate Button
        Button('Authenticate', { type: ButtonType.Capsule, stateEffect: false })
          .width('80%')
          .height(52)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFFFFF')
          .backgroundColor(this.primaryColor)
          .margin({ top: 24 })
          
        Blank() // Push content up
      }
      .layoutWeight(1)
      .padding({ left: 16, right: 16 })
      .linearGradient({
        angle: 90,
        colors: [
          ['#38BDF8', 0.1],
          ['#2563EB', 0.15]
        ]
      })

      // Bottom Navigation Bar
      Row() {
        // Home Tab
        Column() {
          Text('Home')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.selectedTab === 'Home' ? this.primaryColor : this.textColorSecondary)
        }
        .onClick(() => { this.selectedTab = 'Home' })
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)

        // Plan Tab
        Column() {
          Text('Plan')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.selectedTab === 'Plan' ? this.primaryColor : this.textColorSecondary)
        }
        .onClick(() => { this.selectedTab = 'Plan' })
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)

        // Profile Tab
        Column() {
          Text('Profile')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.selectedTab === 'Profile' ? this.primaryColor : this.textColorSecondary)
        }
        .onClick(() => { this.selectedTab = 'Profile' })
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)
      }
      .width('100%')
      .height(80)
      .backgroundColor(this.surfaceColor)
      .shadow({ radius: 8, color: '#00000012', offsetY: -4 }) // Negative Y for shadow above
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8FAFC')
    
    // Floating Action Button (FAB)
    .position({ x: 'auto', y: 'auto' }) // Relative positioning handled by overlay or absolute
    .overlay(
      Column() {
        Button('+', { type: ButtonType.Circle, stateEffect: false })
          .width(56)
          .height(56)
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FFFFFF')
          .backgroundColor(this.primaryColor)
          .shadow({ radius: 8, color: '#00000026', offsetY: 4 })
      }
      .position({ x: 'auto', y: 'auto' })
      .alignSelf(ItemAlign.End)
      .margin({ right: 16, bottom: 96 }) // 16 padding + 80 bottom bar height
    )
  }
}