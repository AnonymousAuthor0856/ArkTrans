@Entry
@Component
struct CourseApp {
  private categories: string[] = ['Coding', 'Design', 'Business', 'Photo', 'Music']
  private courses: Course[] = [
    { title: 'Mobile Dev', subtitle: 'Android Compose', rating: '4.9', bgColor: '#E3F2FD', accentColor: '#1565C0', iconName: '✓' },
    { title: 'Photography', subtitle: 'Master Lighting', rating: '4.7', bgColor: '#FCE4EC', accentColor: '#C62828', iconName: '★' },
    { title: 'Finance', subtitle: 'Crypto Trading', rating: '4.5', bgColor: '#E8F5E9', accentColor: '#2E7D32', iconName: '★' }
  ]

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#F5F5F7')

      List({ space: 0 }) {
        ListItem() {
          Row({ space: 0 }) {
            Column({ space: 4 }) {
              Text('Hello, Sophie')
                .fontSize(28)
                .fontWeight(FontWeight.Bold)
                .foregroundColor('#1C1B1F')
              Text("Let's start learning!")
                .fontSize(16)
                .foregroundColor('#808080')
            }
            .alignItems(HorizontalAlign.Start)
            Blank()
            Row({ space: 8 }) {
              Button() {
                Text('🔔').fontSize(24).foregroundColor('#1C1B1F')
              }
              Stack({ alignContent: Alignment.Center }) {
                Column().width(48).height(48).backgroundColor('#4E31AA').opacity(0.2).borderRadius(24)
                Text('😊').fontSize(24)
              }
              .width(48)
              .height(48)
            }
          }
          .width('100%')
          .padding(24)
        }

        ListItem() {
          Row({ space: 0 }) {
            Text('🔍').fontSize(20).foregroundColor('#808080')
            Blank().width(16)
            TextInput({ placeholder: 'Search for course...', text: '' }).fontSize(16).layoutWeight(1)
            Blank()
            Text('☰').fontSize(20).foregroundColor('#4E31AA')
          }
          .padding({ left: 16, right: 16 })
          .height(56)
          .backgroundColor('#FFFFFF')
          .borderRadius(16)
          .padding({ left: 24, right: 24 })
        }

        ListItem() {
          Column({ space: 16 }) {
            Text('Ongoing Course').fontSize(20).fontWeight(FontWeight.Bold).foregroundColor('#1C1B1F').width('100%')
            Stack() {
              Column().width('100%').height(140).backgroundColor('#4E31AA').borderRadius(24)
              Row({ space: 16 }) {
                Column({ space: 0 }) {
                  Text('3D Modeling').fontSize(14).foregroundColor('#FFFFFF').opacity(0.7)
                  Blank().height(8)
                  Text('Blender Basic').fontSize(22).fontWeight(FontWeight.Bold).foregroundColor('#FFFFFF')
                  Blank().height(16)
                  Row({ space: 8 }) {
                    Text('75%').fontSize(12).foregroundColor('#FFFFFF')
                    Progress({ value: 0.75, total: 1, type: ProgressType.Linear })
                      .height(6).color('#FFA726').backgroundColor('#FFFFFF').opacity(0.2).borderRadius(4).layoutWeight(1)
                  }
                  .width('100%')
                }
                .layoutWeight(1)
                Button() {
                  Text('▶').fontSize(32).foregroundColor('#4E31AA').width(60).height(60).textAlign(TextAlign.Center)
                }
                .width(60)
                .height(60)
                .backgroundColor('#FFFFFF')
                .borderRadius(30)
                .alignSelf(ItemAlign.Center)
              }
              .padding(20)
              .width('100%')
            }
            .width('100%')
          }
          .padding(24)
        }

        ListItem() {
          Row({ space: 12 }) {
            Blank().width(12)
            ForEach(this.categories, (cat: string) => {
              Button() {
                Text(cat).fontSize(14).fontWeight(FontWeight.Medium)
                  .foregroundColor(cat === 'Design' ? '#FFFFFF' : '#808080')
                  .padding({ left: 24, right: 24, top: 12, bottom: 12 })
              }
              .backgroundColor(cat === 'Design' ? '#FF7043' : '#FFFFFF')
              .borderRadius(12)
            })
            Blank().width(12)
          }
          .width('100%')
        }

        ListItem() {
          Column({ space: 16 }) {
            Row({ space: 0 }) {
              Text('Recommended').fontSize(20).fontWeight(FontWeight.Bold).foregroundColor('#1C1B1F')
              Blank()
              Text('See all').fontSize(14).foregroundColor('#808080')
            }
            .width('100%')
            ForEach(this.courses, (course: Course) => {
              this.buildCourseCard(course)
            })
          }
          .padding(24)
        }

        ListItem() {
          Column().height(100).width('100%')
        }
      }
      .width('100%')
      .layoutWeight(1)

      // Bottom navigation bar
      Column() {
        Blank()
        Row({ space: 0 }) {
          Blank()
          Text('🏠').fontSize(20).foregroundColor('#FFFFFF')
          Blank()
          Text('🔍').fontSize(20).foregroundColor('#808080')
          Blank()
          Text('♥').fontSize(20).foregroundColor('#808080')
          Blank()
          Text('👤').fontSize(20).foregroundColor('#808080')
          Blank()
        }
        .width('100%')
        .height(56)
        .padding({ top: 16, bottom: 16 })
        .backgroundColor('#1E1E1E')
        .borderRadius(32)
        .shadow({ radius: 8, color: '#33000000', offsetY: 4 })
        .padding({ left: 24, right: 24 })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  buildCourseCard(course: Course) {
    Stack({ alignContent: Alignment.TopStart }) {
      Column().width('100%').height(100).backgroundColor('#FFFFFF').borderRadius(20)

      Row({ space: 0 }) {
        // Left icon box
        Stack({ alignContent: Alignment.Center }) {
          Column().width(100).height(100).backgroundColor(course.bgColor)
            .borderRadius({ topLeft: 20, bottomLeft: 20 })
          Text(course.iconName).fontSize(32).foregroundColor(course.accentColor)
        }
        .width(100)
        .height(100)

        Column({ space: 4 }) {
          Text(course.subtitle).fontSize(12).fontWeight(FontWeight.Bold).foregroundColor('#4E31AA')
          Text(course.title).fontSize(16).fontWeight(FontWeight.Bold).foregroundColor('#1C1B1F')
          Row({ space: 4 }) {
            Text('★').fontSize(12).foregroundColor('#FFB300')
            Text(course.rating).fontSize(12).foregroundColor('#808080')
          }
        }
        .padding(16)
        .layoutWeight(1)

        Button() {
          Text('♥').fontSize(20).foregroundColor('#EEEEEE')
        }
        .margin({ right: 16 })
        .alignSelf(ItemAlign.Center)
      }
      .width('100%')
      .height(100)
    }
    .width('100%')
    .height(100)
  }
}

interface Course {
  title: string
  subtitle: string
  rating: string
  bgColor: string
  accentColor: string
  iconName: string
}