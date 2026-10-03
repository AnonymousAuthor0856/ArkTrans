import { Scroller } from '@kit.ArkUI'

interface TaskItem {
  id: number;
  title: string;
  plantName: string;
  urgency: string;
  iconName: string;
  isChecked: boolean;
}

interface PlantItem {
  id: number;
  name: string;
  scientificName: string;
  location: string;
  daysUntilWater: number;
}

@Component
struct BotanyNavItem {
  @Prop iconName: Resource = $r('app.media.startIcon')
  @Prop isSelected: boolean = false

  build() {
    Column() {
      Image(this.iconName)
        .width(24)
        .height(24)
        .objectFit(ImageFit.Contain)
        .fillColor(this.isSelected ? '#2E5E4E' : '#757575')
    }
  }
}

@Entry
@Component
struct Index {
  @State selectedTab: number = 0

  build() {
    Stack() {
      // === ZStack ===
      Stack({ alignContent: Alignment.Bottom }) {
        // === VStack ===
        Column({ space: 0 }) {
          // === HStack ===
          Row() {
            Button('Action1')
            Blank()
            Button('Action2')
          }

          // === ScrollView ===
          Scroll(new Scroller()) {
            // === VStack ===
            Column() {
              .width('100%')
              .padding({ bottom: 80 })
              .alignItems(HorizontalAlign.Start)

              // === VStack ===
              Column() {
                .padding({ left: 24, right: 24, top: 16, bottom: 16 })
                .alignItems(HorizontalAlign.Start)

                // === Text ===
                Text('Good Morning,')
                  .fontColor('#757575') // botanyTextSecondary approx
                  .fontSize(17) // body

                // === Text ===
                Text('My Jungle')
                  .fontColor('#000000') // botanyTextPrimary approx
                  .fontWeight(FontWeight.Bold)
                  .fontSize(34) // largeTitle
              }

              // === Text ===
              Text('Tasks')
                .fontColor('#000000')
                .padding({ left: 24, right: 24, top: 12, bottom: 12 })
                .fontWeight(FontWeight.Bold)
                .fontSize(22) // title2

              // === ScrollView (Horizontal) ===
              Scroll(new Scroller(), { scrollable: ScrollDirection.Horizontal }) {
                // === HStack ===
                Row({ space: 16 }) {
                  .padding({ left: 24, right: 24 })

                  // === ForEach ===
                  ForEach([
                    { id: 1, title: 'Water Plants', plantName: 'Monstera', urgency: 'High', iconName: 'leaf.fill', isChecked: false },
                    { id: 2, title: 'Prune Leaves', plantName: 'Fiddle Leaf', urgency: 'Low', iconName: 'scissors.fill', isChecked: true }
                  ] as TaskItem[], (task: TaskItem) => {
                    // === VStack (Card) ===
                    Column() {
                      .width(160)
                      .height(180)
                      .borderRadius(24)
                      .backgroundColor('#F5F5F5') // botanySurface approx
                      .onClick(() => {
                        // toggle logic would go here
                      })
                      .borderWidth(task.isChecked ? 2 : 0)
                      .borderColor('#2E5E4E') // botanyAccent approx

                      // === HStack ===
                      Row() {
                        // === ZStack ===
                        Stack() {
                          // === Circle ===
                          Circle()
                            .width(40)
                            .height(40)
                            .fill(task.isChecked ? '#2E5E4E' : '#FFFFFF')

                          // === Image ===
                          Image($r('app.media.startIcon')) // Using required resource
                            .width(20)
                            .height(20)
                            .objectFit(ImageFit.Contain)
                            .fillColor(task.isChecked ? '#FFFFFF' : '#000000')
                        }
                        Blank()
                      }

                      Blank()

                      // === VStack ===
                      Column() {
                        .alignItems(HorizontalAlign.Start)
                        .space(0)

                        // === Text ===
                        Text(task.title)
                          .fontColor('#000000')
                          .fontWeight(FontWeight.Bold)
                          .fontSize(17)

                        // === Text ===
                        Text(task.plantName)
                          .fontColor('#757575')
                          .fontSize(12) // caption
                          .maxLines(1)
                          .textOverflow({ overflow: TextOverflow.Ellipsis })

                        // === Spacer ===
                        Blank().height(8)

                        // === Text ===
                        Text(task.isChecked ? "DONE" : task.urgency)
                          .fontColor(task.isChecked ? '#FFFFFF' : '#000000')
                          .fontSize(11) // caption2
                          .fontWeight(FontWeight.Bold)
                          .backgroundColor(task.isChecked ? '#2E5E4E' : '#E0E0E0')
                          .borderRadius(4)
                          .padding({ left: 6, right: 6, top: 2, bottom: 2 })
                      }
                    }
                  })
                }
              }.padding({ bottom: 32 })

              // === Text ===
              Text('Plants')
                .fontColor('#000000')
                .padding({ left: 24, right: 24, top: 12, bottom: 12 })
                .fontWeight(FontWeight.Bold)
                .fontSize(22)

              // === ForEach ===
              ForEach([
                { id: 1, name: 'Monstera Deliciosa', scientificName: 'Monstera deliciosa', location: 'Living Room', daysUntilWater: 0 },
                { id: 2, name: 'Snake Plant', scientificName: 'Sansevieria trifasciata', location: 'Bedroom', daysUntilWater: 5 }
              ] as PlantItem[], (plant: PlantItem) => {
                // === HStack ===
                Row() {
                  .alignItems(VerticalAlign.Center)
                  .padding({ left: 24, right: 24, top: 8, bottom: 8 })
                  .borderRadius(16)
                  .backgroundColor('#F5F5F5')
                  .margin({ bottom: 8 })
                  .onClick(() => {
                    // expand logic
                  })

                  // === ZStack ===
                  Stack() {
                    // === RoundedRectangle ===
                    Rect()
                      .width(56)
                      .height(56)
                      .borderRadius(12)
                      .fill(Color('#EEEEEE'))

                    // === Image ===
                    Image($r('app.media.startIcon')) // Using required resource as placeholder for heart
                      .width(24)
                      .height(24)
                      .objectFit(ImageFit.Contain)
                      .fillColor(plant.daysUntilWater == 0 ? '#2E5E4E' : Color('#CCCCCC'))
                  }

                  // === Spacer ===
                  Blank().width(16)

                  // === VStack ===
                  Column() {
                    .alignItems(HorizontalAlign.Start)
                    .layoutWeight(1)

                    // === Text ===
                    Text(plant.name)
                      .fontColor('#000000')
                      .fontWeight(FontWeight.Bold)
                      .fontSize(20) // headline

                    // === Text ===
                    Text(plant.scientificName)
                      .fontColor('#757575')
                      .fontSize(12) // caption
                      .fontStyle(FontStyle.Italic)

                    // === Spacer ===
                    Blank().height(8)

                    // === HStack ===
                    Row() {
                      .alignItems(VerticalAlign.Center)

                      // === Image ===
                      Image($r('app.media.startIcon')) // Placeholder for location icon
                        .width(12)
                        .height(12)
                        .objectFit(ImageFit.Contain)
                        .fillColor('#757575')

                      // === Spacer ===
                      Blank().width(4)

                      // === Text ===
                      Text(plant.location)
                        .fontColor('#757575')
                        .fontSize(11) // caption2
                    }
                  }

                  // === VStack ===
                  Column() {
                    .alignItems(HorizontalAlign.End)

                    // === Image ===
                    Image($r('app.media.startIcon')) // Placeholder for checkmark
                      .width(24)
                      .height(24)
                      .objectFit(ImageFit.Contain)
                      .fillColor('#2E5E4E')

                    // === Text ===
                    Text('Water')
                      .fontWeight(FontWeight.Bold)
                      .fontColor('#2E5E4E')
                      .fontSize(11)

                    // === Text ===
                    Text(`${plant.daysUntilWater} days`)
                      .fontColor('#757575')
                      .fontSize(11)
                  }
                }
              })
            }
          }
        }

        // === VStack (Overlay) ===
        Column() {
          .zIndex(1)
          Blank()
          Row() {
            Blank()
            Button('+')
              .padding({ bottom: 96, right: 24 })
              .backgroundColor('#2E5E4E')
              .borderRadius(50)
              .width(56)
              .height(56)
          }
        }

        // === HStack (Bottom Nav) ===
        Row({ space: 0 }) {
          .width('100%')
          .padding({ top: 24, bottom: 24, left: 48, right: 48 })
          .backgroundColor('#FFFFFF')

          // === BotanyNavItem ===
          BotanyNavItem({ iconName: $r('app.media.startIcon'), isSelected: this.selectedTab == 0 })
            .onClick(() => { this.selectedTab = 0 })

          // === BotanyNavItem ===
          BotanyNavItem({ iconName: $r('app.media.startIcon'), isSelected: this.selectedTab == 1 })
            .onClick(() => { this.selectedTab = 1 })

          // === Spacer ===
          Blank().width(32)

          // === BotanyNavItem ===
          BotanyNavItem({ iconName: $r('app.media.startIcon'), isSelected: this.selectedTab == 2 })
            .onClick(() => { this.selectedTab = 2 })

          // === BotanyNavItem ===
          BotanyNavItem({ iconName: $r('app.media.startIcon'), isSelected: this.selectedTab == 3 })
            .onClick(() => { this.selectedTab = 3 })
        }
      }
    }.width('100%').height('100%')
  }
}