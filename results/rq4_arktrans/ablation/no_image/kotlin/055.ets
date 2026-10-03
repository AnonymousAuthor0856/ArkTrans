@Entry
@Component
struct Index {
  @State SignInToContinue: string = 'Sign In to Continue'
  @State WorkoutPreview: string = 'Workout Preview'
  @State Authenticate: string = 'Authenticate'
  @State Plus: string = '+'
  @State Home: string = 'Home'
  @State Plan: string = 'Plan'
  @State Profile: string = 'Profile'
  @State WorkoutPlan: string = 'Workout Plan'

  build() {
    Stack() {
      // === Scaffold ===
      Stack({ alignContent: Alignment.Top }) {
        // === Column ===
        Column({ space: 16 }) {
          // === Text ===
          Text(this.SignInToContinue)
            .fontSize(28)
            .fontWeight(FontWeight.Medium)
            .fontColor('#1E293B')

          // === Box ===
          Stack({ alignContent: Alignment.Center }) {
            // === Text ===
            Text(this.WorkoutPreview)
              .fontSize(14)
              .fontColor('#1E293B')
          }
          .width('100%')
          .height(200)
          .backgroundColor('#FFFFFF')
          .borderRadius(16)
          .border({ width: 1, color: '#CBD5E1', radius: 16 })

          // === Button ===
          Button() {
            // === Text ===
            Text(this.Authenticate)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
          }
          .width('80%')
          .height(52)
          .backgroundColor('#2563EB')
          .borderRadius(16)
          .onClick(() => {
            // onClick handler
          })
        }
        .alignItems(HorizontalAlign.Center)
        .width('100%')
        .height('100%')
        .padding(16)
        .linearGradient({
          direction: GradientDirection.Bottom,
          colors: [['#F8FAFC', 0], ['#EFF6FF', 1]]
        })

        // === FloatingActionButton ===
        Button() {
          // === Text ===
          Text(this.Plus)
            .fontSize(48)
            .fontColor('#FFFFFF')
        }
        .width(56)
        .height(56)
        .backgroundColor('#2563EB')
        .borderRadius(28)
        .position({ x: 'calc(100% - 80px)', y: 'calc(100% - 120px)' })
        .onClick(() => {
          // onClick handler
        })

        // === BottomAppBar ===
        Row({ space: 0 }) {
          // === Text ===
          Text(this.Home)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#2563EB')
          
          // === Text ===
          Text(this.Plan)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#1E293B')
          
          // === Text ===
          Text(this.Profile)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#1E293B')
        }
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.SpaceBetween)
        .width('100%')
        .height(56)
        .padding({ left: 16, right: 16 })
        .backgroundColor('#FFFFFF')
        .shadow({ radius: 4, color: '#1F000000', offsetY: -2 })
        .position({ x: 0, y: 'calc(100% - 56px)' })

        // === CenterAlignedTopAppBar ===
        Text(this.WorkoutPlan)
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0F172A')
          .textAlign(TextAlign.Center)
          .width('100%')
          .height(56)
          .padding({ top: 16 })
          .position({ x: 0, y: 0 })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}