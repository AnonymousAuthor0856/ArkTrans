// src/main/ets/view/HealthDashboard.ets

@Entry
@Component
struct HealthDashboard {
  @State selectedNav: number = 0

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      // === Main Content Column ===
      // props: { space: 12 }
      // modifier: { width: '100%', padding: { left: 8, right: 8 }, backgroundColor: '#F8FAFC' }
      // children: 5
      Column() {
        // === Text (Title) ===
        // props: { text: 'Health Dashboard' }
        // modifier: { fontSize: 24, fontWeight: FontWeight.Bold, color: '#0F172A', margin: { top: 40, bottom: 16 } }
        Text('Health Dashboard')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0F172A')
          .margin({ top: 40, bottom: 16 })

        // === Card (Hero) ===
        // props: { space: 4 }
        // modifier: { width: '100%', borderRadius: 16, backgroundColor: '#6366F1', padding: 16, shadow: { radius: 12, color: '#38000000', offsetY: 3 } }
        // children: 3
        Column() {
          // === Text ===
          // props: { text: 'Good Morning!' }
          // modifier: { fontSize: 16, fontWeight: FontWeight.Medium, color: '#FFF' }
          Text('Good Morning!')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFF')

          // === Text ===
          // props: { text: 'Ready for your workout?' }
          // modifier: { fontSize: 20, fontWeight: FontWeight.SemiBold, color: '#FFF' }
          Text('Ready for your workout?')
            .fontSize(20)
            .fontWeight(FontWeight.Semibold)
            .fontColor('#FFF')

          // === Button ===
          // props: { type: ButtonType.Capsule }
          // modifier: { width: '100%', height: 44, backgroundColor: '#FFF', fontColor: '#6366F1', marginTop: 8 }
          // children: 1
          Button() {
            // === Text ===
            // props: { text: 'Start Workout' }
            // modifier: { fontSize: 16, fontWeight: FontWeight.Medium }
            Text('Start Workout')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
          }
          .type(ButtonType.Capsule)
          .width('100%')
          .height(44)
          .backgroundColor('#FFF')
          .fontColor('#6366F1')
          .margin({ top: 8 })
        }
        .width('100%')
        .borderRadius(16)
        .backgroundColor('#6366F1')
        .padding(16)
        .shadow({ radius: 12, color: '#38000000', offsetY: 3 })

        // === Text (Section Title) ===
        // props: { text: "Today's Metrics" }
        // modifier: { fontSize: 20, fontWeight: FontWeight.SemiBold, color: '#0F172A', margin: { top: 12, bottom: 8 } }
        Text("Today's Metrics")
          .fontSize(20)
          .fontWeight(FontWeight.Semibold)
          .fontColor('#0F172A')
          .margin({ top: 12, bottom: 8 })

        // === Row (Metrics Grid) ===
        // props: { space: 8 }
        // modifier: { width: '100%' }
        // children: 4
        Row() {
          // Metric Item 1
          this.MetricCard('Heart', '72', '#EC4899')
          // Metric Item 2
          this.MetricCard('Steps', '842', '#6366F1')
          // Metric Item 3
          this.MetricCard('Sleep', '7.2', '#10B981')
          // Metric Item 4
          this.MetricCard('Calories', '420', '#EF4444')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)

        // === Row (Workouts Header) ===
        // props: { space: 8 }
        // modifier: { width: '100%', alignItems: VerticalAlign.Center, justifyContent: FlexAlign.SpaceBetween, margin: { top: 12, bottom: 8 } }
        // children: 2
        Row() {
          // === Text ===
          // props: { text: 'Recent Workouts' }
          // modifier: { fontSize: 20, fontWeight: FontWeight.SemiBold, color: '#0F172A' }
          Text('Recent Workouts')
            .fontSize(20)
            .fontWeight(FontWeight.Semibold)
            .fontColor('#0F172A')

          // === Text (View All) ===
          // props: { text: 'View All' }
          // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, color: '#6366F1' }
          Text('View All')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#6366F1')
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.SpaceBetween)
        .margin({ top: 12, bottom: 8 })

        // === Column (Workout List) ===
        // props: { space: 8 }
        // modifier: { width: '100%' }
        // children: 2
        Column() {
          // Workout Item 1
          this.WorkoutItem('Morning Run', '32 min', '284 kcal', '#6366F1')
          // Workout Item 2
          this.WorkoutItem('Yoga Flow', '45 min', '156 kcal', '#EC4899')
        }
        .width('100%')
        
        // Spacer to push content up if needed, though layoutWeight on list usually handles this
        Blank()
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 8, right: 8 })
      .backgroundColor('#F8FAFC')

      // === Bottom Navigation Bar ===
      // props: { space: 0 }
      // modifier: { width: '100%', height: 80, backgroundColor: '#F1F5F9', justifyContent: FlexAlign.SpaceAround, paddingTop: 16 }
      // children: 4
      Row() {
        this.NavItem('Dashboard', 0)
        this.NavItem('Workouts', 1)
        this.NavItem('Nutrition', 2)
        this.NavItem('Profile', 3)
      }
      .width('100%')
      .height(80)
      .backgroundColor('#F1F5F9')
      .justifyContent(FlexAlign.SpaceAround)
      .padding({ top: 16 })
    }
    .width('100%')
    .height('100%')
  }

  // === Reusable Components ===

  @Builder
  MetricCard(title: string, value: string, color: string) {
    // === Column ===
    // props: { space: 2, horizontalAlignment: HorizontalAlign.Center }
    // modifier: { width: '23%', borderRadius: 12, backgroundColor: '#FFF', padding: 8, shadow: { radius: 8, color: '#2E000000', offsetY: 2 } }
    // children: 3
    Column() {
      // === Circle Icon ===
      // modifier: { width: 36, height: 36, backgroundColor: color }
      Row()
        .width(36)
        .height(36)
        .borderRadius(18)
        .backgroundColor(color)

      // === Text (Value) ===
      // props: { text: value }
      // modifier: { fontSize: 20, fontWeight: FontWeight.SemiBold, color: '#0F172A' }
      Text(value)
        .fontSize(20)
        .fontWeight(FontWeight.Semibold)
        .fontColor('#0F172A')

      // === Text (Title) ===
      // props: { text: title }
      // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, color: '#64748B' }
      Text(title)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#64748B')
    }
    .width('23%')
    .borderRadius(12)
    .backgroundColor('#FFF')
    .padding(8)
    .shadow({ radius: 8, color: '#2E000000', offsetY: 2 })
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  WorkoutItem(name: string, duration: string, calories: string, color: string) {
    // === Row ===
    // props: { space: 8, verticalAlignment: VerticalAlign.Center }
    // modifier: { width: '100%', borderRadius: 12, backgroundColor: '#FFF', padding: 8, shadow: { radius: 4, color: '#1A000000', offsetY: 1 } }
    // children: 3
    Row() {
      // === Icon Box ===
      // modifier: { width: 44, height: 44, borderRadius: 12, backgroundColor: color }
      Row()
        .width(44)
        .height(44)
        .borderRadius(12)
        .backgroundColor(color)

      // === Info Column ===
      // props: { space: 2 }
      // modifier: { layoutWeight: 1 }
      // children: 2
      Column() {
        // === Text (Name) ===
        // props: { text: name }
        // modifier: { fontSize: 16, fontWeight: FontWeight.Medium, color: '#0F172A' }
        Text(name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#0F172A')

        // === Row (Details) ===
        // props: { space: 12 }
        // children: 2
        Row() {
          // === Text (Duration) ===
          // props: { text: duration }
          // modifier: { fontSize: 14, fontWeight: FontWeight.Normal, color: '#64748B' }
          Text(duration)
            .fontSize(14)
            .fontWeight(FontWeight.Normal)
            .fontColor('#64748B')

          // === Text (Calories) ===
          // props: { text: calories }
          // modifier: { fontSize: 14, fontWeight: FontWeight.Normal, color: '#64748B' }
          Text(calories)
            .fontSize(14)
            .fontWeight(FontWeight.Normal)
            .fontColor('#64748B')
        }
        .space(12)
      }
      .layoutWeight(1)
      .space(2)

      // === Button (Star) ===
      // props: { type: ButtonType.Capsule }
      // modifier: { width: 70, height: 32, backgroundColor: '#6366F1', fontColor: '#FFF' }
      // children: 1
      Button() {
        // === Text ===
        // props: { text: 'Star' }
        // modifier: { fontSize: 10, fontWeight: FontWeight.Normal }
        Text('Star')
          .fontSize(10)
          .fontWeight(FontWeight.Normal)
      }
      .type(ButtonType.Capsule)
      .width(70)
      .height(32)
      .backgroundColor('#6366F1')
      .fontColor('#FFF')
    }
    .width('100%')
    .borderRadius(12)
    .backgroundColor('#FFF')
    .padding(8)
    .shadow({ radius: 4, color: '#1A000000', offsetY: 1 })
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  NavItem(label: string, index: number) {
    // === Column ===
    // props: { space: 4, horizontalAlignment: HorizontalAlign.Center }
    // children: 2
    Column() {
      // === Indicator ===
      // modifier: { width: 20, height: 20, borderRadius: 10, backgroundColor: isSelected ? '#6366F1' : '#CBD5E1' }
      Row()
        .width(20)
        .height(20)
        .borderRadius(10)
        .backgroundColor(this.selectedNav === index ? '#6366F1' : '#CBD5E1')

      // === Text ===
      // props: { text: label }
      // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, color: isSelected ? '#0F172A' : '#64748B' }
      Text(label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.selectedNav === index ? '#0F172A' : '#64748B')
    }
    .space(4)
    .alignItems(HorizontalAlign.Center)
    .onClick(() => {
      this.selectedNav = index
    })
  }
}