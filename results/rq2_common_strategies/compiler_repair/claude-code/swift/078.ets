import promptAction from '@ohos.promptAction';

@Entry
@Component
struct CourseApp {
  @State selectedCategory: string = 'Design';
  private categories: string[] = ['Coding', 'Design', 'Business', 'Photo', 'Music'];
  private courses: CourseData[] = [
    new CourseData('Mobile Dev', 'Android Compose', '4.9', '#E3F2FD', '#1565C0', '✓'),
    new CourseData('Photography', 'Master Lighting', '4.7', '#FCE4EC', '#C2185B', '★'),
    new CourseData('Finance', 'Crypto Trading', '4.5', '#E8F5E9', '#2E7D32', '★')
  ];

  build() {
    Stack() {
      Column() {
        Scroll() {
          Column() {
            // Header Section
            Row() {
              Column() {
                Text('Hello, Sophie')
                  .fontSize(28)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#1C1B1F')
                Text('Let\'s start learning!')
                  .fontSize(16)
                  .fontColor('#9E9E9E')
                  .margin({ top: 4 })
              }
              .alignItems(HorizontalAlign.Start)

              Blank()

              Row() {
                Text('🔔')
                  .fontSize(24)
                  .onClick(() => {
                    promptAction.showToast({ message: 'Notifications' });
                  })

                Stack() {
                  Circle({ width: 48, height: 48 })
                    .fill('rgba(78, 49, 170, 0.2)')
                  Text('😊')
                    .fontSize(24)
                    .fontColor('#4E31AA')
                }
              }
              .margin({ left: 8 })
            }
            .width('100%')
            .padding(24)

            // Search Bar Section
            Row() {
              Text('🔍')
                .fontSize(18)
                .fontColor('#9E9E9E')

              Text('Search for course...')
                .fontSize(16)
                .fontColor('#BDBDBD')
                .margin({ left: 16 })

              Blank()

              Text('≡')
                .fontSize(22)
                .fontColor('#4E31AA')
            }
            .width('100%')
            .height(56)
            .padding({ left: 16, right: 16 })
            .backgroundColor('#FFFFFF')
            .borderRadius(16)
            .margin({ left: 24, right: 24 })

            // Ongoing Course Section
            Column() {
              Text('Ongoing Course')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .fontColor('#1C1B1F')
                .alignSelf(ItemAlign.Start)

              Stack() {
                Stack() {
                }
                .width('100%')
                .height(140)
                .backgroundColor('#4E31AA')
                .borderRadius(24)

                Row() {
                  Column() {
                    Text('3D Modeling')
                      .fontSize(14)
                      .fontColor('rgba(255, 255, 255, 0.7)')

                    Text('Blender Basic')
                      .fontSize(22)
                      .fontWeight(FontWeight.Bold)
                      .fontColor('#FFFFFF')
                      .margin({ top: 8 })

                    Row() {
                      Text('75%')
                        .fontSize(12)
                        .fontColor('#FFFFFF')

                      // Progress bar
                      Stack({ alignContent: Alignment.Start }) {
                        Stack() {
                        }
                        .width('100%')
                        .height(6)
                        .backgroundColor('rgba(255, 255, 255, 0.2)')
                        .borderRadius(4)

                        Stack() {
                        }
                        .width('75%')
                        .height(6)
                        .backgroundColor('#FFA726')
                        .borderRadius(4)
                      }
                      .width('100%')
                      .layoutWeight(1)
                      .margin({ left: 8 })
                    }
                    .width('100%')
                    .margin({ top: 16 })
                    .alignItems(VerticalAlign.Center)
                  }
                  .alignItems(HorizontalAlign.Start)
                  .layoutWeight(1)

                  Stack() {
                    Circle({ width: 60, height: 60 })
                      .fill('#FFFFFF')
                    Text('▶')
                      .fontSize(24)
                      .fontColor('#4E31AA')
                      .margin({ left: 3 })
                  }
                }
                .width('100%')
                .height(140)
                .padding(20)
                .alignItems(VerticalAlign.Center)
              }
              .width('100%')
              .margin({ top: 16 })
            }
            .width('100%')
            .padding(24)
            .alignItems(HorizontalAlign.Start)

            // Categories Section
            Scroll() {
              Row() {
                ForEach(this.categories, (category: string) => {
                  Text(category)
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(category === this.selectedCategory ? '#FFFFFF' : '#9E9E9E')
                    .padding({ left: 24, right: 24, top: 12, bottom: 12 })
                    .backgroundColor(category === this.selectedCategory ? '#FF7043' : '#FFFFFF')
                    .borderRadius(12)
                    .onClick(() => {
                      this.selectedCategory = category;
                    })
                }, (category: string) => category)
              }
              .padding({ left: 24, right: 24 })
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .width('100%')

            // Recommended Section
            Column() {
              Row() {
                Text('Recommended')
                  .fontSize(20)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#1C1B1F')
                Blank()
                Text('See all')
                  .fontSize(14)
                  .fontColor('#9E9E9E')
              }
              .width('100%')

              Column() {
                ForEach(this.courses, (course: CourseData) => {
                  this.CourseCardBuilder(course)
                }, (course: CourseData) => course.title)
              }
              .width('100%')
              .margin({ top: 16 })
            }
            .width('100%')
            .padding(24)
            .alignItems(HorizontalAlign.Start)

            // Bottom padding for floating nav bar
            Blank()
              .height(100)
          }
          .width('100%')
        }
        .scrollable(ScrollDirection.Vertical)
        .scrollBar(BarState.Off)
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F5F5F7')

      // Bottom Navigation Bar (floating)
      Column() {
        Blank()
        Row() {
          Blank()
          Text('🏠')
            .fontSize(22)
            .fontColor('#FFFFFF')
          Blank()
          Text('🔍')
            .fontSize(22)
            .fontColor('#9E9E9E')
          Blank()
          Text('❤️')
            .fontSize(22)
            .fontColor('#9E9E9E')
          Blank()
          Text('👤')
            .fontSize(22)
            .fontColor('#9E9E9E')
          Blank()
        }
        .width('100%')
        .padding({ top: 16, bottom: 16 })
        .backgroundColor('#1E1E1E')
        .borderRadius(32)
        .margin({ left: 24, right: 24, bottom: 24 })
        .shadow({ radius: 8, color: 'rgba(0, 0, 0, 0.2)', offsetX: 0, offsetY: 4 })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  CourseCardBuilder(course: CourseData) {
    Stack() {
      Stack() {
      }
      .width('100%')
      .height(100)
      .backgroundColor('#FFFFFF')
      .borderRadius(20)

      Row() {
        // Left Icon Box
        Stack() {
          Stack() {
          }
          .width('100%')
          .height('100%')
          .backgroundColor(course.bgColor)
          Text(course.iconName)
            .fontSize(32)
            .fontColor(course.accentColor)
        }
        .width(100)
        .height('100%')
        .borderRadius({ topLeft: 20, bottomLeft: 20 })

        // Content
        Column() {
          Text(course.subtitle)
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .fontColor('#4E31AA')

          Text(course.title)
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#1C1B1F')
            .margin({ top: 4 })

          Row() {
            Text('★')
              .fontSize(12)
              .fontColor('#FFB300')
            Text(course.rating)
              .fontSize(12)
              .fontColor('#9E9E9E')
              .margin({ left: 4 })
          }
          .margin({ top: 4 })
        }
        .alignItems(HorizontalAlign.Start)
        .padding(16)
        .layoutWeight(1)

        // Favorite Icon
        Text('♡')
          .fontSize(20)
          .fontColor('#EEEEEE')
          .padding({ right: 16 })
          .onClick(() => {
            promptAction.showToast({ message: 'Added to favorites' });
          })
      }
      .width('100%')
      .height(100)
    }
    .width('100%')
    .height(100)
    .margin({ bottom: 12 })
  }
}

class CourseData {
  title: string;
  subtitle: string;
  rating: string;
  bgColor: string;
  accentColor: string;
  iconName: string;

  constructor(title: string, subtitle: string, rating: string,
              bgColor: string, accentColor: string, iconName: string) {
    this.title = title;
    this.subtitle = subtitle;
    this.rating = rating;
    this.bgColor = bgColor;
    this.accentColor = accentColor;
    this.iconName = iconName;
  }
}
