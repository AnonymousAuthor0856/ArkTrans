@Entry
@Component
struct Index {
  @State workouts: WorkoutItem[] = [
    { id: '1', title: 'Morning Run', duration: '32 min', calories: '284 kcal', color: '#6366F1' },
    { id: '2', title: 'Yoga Flow', duration: '45 min', calories: '156 kcal', color: '#EC4899' }
  ]

  build() {
    Stack() {
      Column() {
        // Header Section
        Column() {
          Text('Health Dashboard')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor('#1E293B')
            .margin({ top: 40, bottom: 24 })
            .textAlign(TextAlign.Center)
        }.width('100%')

        Scroll() {
          Column() {
            // Hero Card
            Row() {
              Column() {
                Text('Good Morning!')
                  .fontSize(20)
                  .fontColor('#FFFFFF')
                  .margin({ bottom: 8 })
                
                Text('Ready for your workout?')
                  .fontSize(28)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#FFFFFF')
                  .margin({ bottom: 24 })
                
                Button('Start Workout')
                  .backgroundColor('#FFFFFF')
                  .fontColor('#6366F1')
                  .fontWeight(FontWeight.Medium)
                  .fontSize(18)
                  .borderRadius(16)
                  .height(56)
                  .width('100%')
              }
              .alignItems(HorizontalAlign.Start)
              .justifyContent(FlexAlign.Start)
              .padding(24)
              .width('100%')
            }
            .backgroundColor('#6366F1')
            .borderRadius(24)
            .shadow({ radius: 12, color: '#00000020', offsetY: 4 })
            .margin({ left: 16, right: 16, bottom: 32 })

            // Metrics Section
            Column() {
              Text("Today's Metrics")
                .fontSize(20)
                .fontWeight(FontWeight.Medium)
                .fontColor('#1E293B')
                .margin({ bottom: 16 })
            
              Grid() {
                GridItem() { this.MetricCard('72', 'Heart', '#EC4899') }
                GridItem() { this.MetricCard('842', 'Steps', '#6366F1') }
                GridItem() { this.MetricCard('7.2', 'Sleep', '#10B981') }
                GridItem() { this.MetricCard('420', 'Calories', '#EF4444') }
              }
              .columnsTemplate('1fr 1fr 1fr 1fr')
              .columnsGap(12)
              .rowsGap(12)
            }.margin({ left: 16, right: 16, bottom: 32 })

            // Recent Workouts
            Column() {
              Row() {
                Text('Recent Workouts')
                  .fontSize(24)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#1E293B')
                Blank()
                Text('View All')
                  .fontSize(16)
                  .fontColor('#6366F1')
                  .fontWeight(FontWeight.Medium)
              }.width('100%').margin({ bottom: 16 })

              ForEach(this.workouts, (item: WorkoutItem) => {
                this.WorkoutRow(item)
              })
            }.margin({ left: 16, right: 16, bottom: 100 })
          }
          .padding({ left: 16, right: 16 })
        }.layoutWeight(1)
      }.width('100%').height('100%').backgroundColor('#F8FAFC')

      // Bottom Navigation
      Row() {
        this.NavItem('Dashboard', true)
        this.NavItem('Workouts', false)
        this.NavItem('Nutrition', false)
        this.NavItem('Profile', false)
      }
      .width('100%')
      .height(80)
      .backgroundColor('#FFFFFF')
      .shadow({ radius: 12, color: '#00000010', offsetY: -4 })
      .position({ x: 0, y: 0 })
      .alignSelf(ItemAlign.End)
    }.width('100%').height('100%')
  }

  @Builder
  MetricCard(value: string, label: string, color: string) {
    Column() {
      Circle()
        .width(48)
        .height(48)
        .fill(color)
        .margin({ bottom: 12 })
      
      Text(value)
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1E293B')
        .margin({ bottom: 4 })
      
      Text(label)
        .fontSize(16)
        .fontColor('#64748B')
    }
    .width('100%')
    .height(140)
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(20)
    .shadow({ radius: 8, color: '#00000010', offsetY: 2 })
  }

  @Builder
  WorkoutRow(item: WorkoutItem) {
    Row() {
      Rect()
        .width(64)
        .height(64)
        .fill(item.color)
        .borderRadius(16)
        .margin({ right: 16 })
      
      Column() {
        Text(item.title)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1E293B')
          .margin({ bottom: 8 })
        
        Row() {
          Text(item.duration)
            .fontSize(16)
            .fontColor('#64748B')
            .margin({ right: 16 })
          
          Text(item.calories)
            .fontSize(16)
            .fontColor('#64748B')
        }
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      
      Button('Start')
        .backgroundColor('#6366F1')
        .fontColor('#FFFFFF')
        .borderRadius(12)
        .height(44)
        .width(100)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(20)
    .shadow({ radius: 8, color: '#00000010', offsetY: 2 })
    .margin({ bottom: 16 })
  }

  @Builder
  NavItem(label: string, active: boolean) {
    Column() {
      Circle()
        .width(8)
        .height(8)
        .fill(active ? '#6366F1' : '#E2E8F0')
        .margin({ bottom: 8 })
      
      Text(label)
        .fontSize(14)
        .fontColor(active ? '#1E293B' : '#64748B')
        .fontWeight(active ? FontWeight.Medium : FontWeight.Normal)
    }
    .layoutWeight(1)
    .justifyContent(FlexAlign.Center)
  }
}

interface WorkoutItem {
  id: string
  title: string
  duration: string
  calories: string
  color: string
}