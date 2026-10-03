class AppTheme {
  static readonly primary: string = '#FF4E31AA'
  static readonly secondary: string = '#FF3A1C71'
  static readonly background: string = '#FFF5F5F7'
  static readonly surface: string = '#FFFFFFFF'
  static readonly onBackground: string = '#FF1C1B1F'
  static readonly progressColor: string = '#FFFFA726'
  static readonly selectedCategoryColor: string = '#FFFF7043'
  static readonly primary20: string = '#334E31AA'
  static readonly white70: string = '#B3FFFFFF'
  static readonly white20: string = '#33FFFFFF'
  static readonly gray: string = '#FF808080'
  static readonly lightGray: string = '#FFAAAAAA'
  static readonly black: string = '#FF000000'
  static readonly bottomNavBg: string = '#FF1E1E1E'
  static readonly starAmber: string = '#FFFFB300'
  static readonly heartGray: string = '#FFEEEEEE'
}

@Entry
@Component
struct Index {
  build() {
    Stack() {
      Column() {
        Scroll() {
          Column() {
            HeaderSection()
            SearchBarSection()
            OngoingCourseSection()
            CategoriesSection()
            RecommendedSection()
            Blank().height(100)
          }
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
      }

      Stack() {
        Row() {
          Blank()
          Text('⌂')
            .fontSize(24)
            .fontColor('#FFFFFFFF')
          Blank()
          Text('🔍')
            .fontSize(24)
            .fontColor(AppTheme.gray)
          Blank()
          Text('♥')
            .fontSize(24)
            .fontColor(AppTheme.gray)
          Blank()
          Text('◉')
            .fontSize(24)
            .fontColor(AppTheme.gray)
          Blank()
        }
        .padding({ top: 16, bottom: 16 })
        .backgroundColor(AppTheme.bottomNavBg)
        .borderRadius(32)
        .shadow({ radius: 8, color: '#33000000', offsetY: 4 })
        .padding({ left: 24, right: 24 })
        .margin({ bottom: 24 })
      }
      .width('100%')
      .height('100%')
      .alignContent(Alignment.Bottom)
    }
    .backgroundColor(AppTheme.background)
    .width('100%')
    .height('100%')
  }
}

@Component
struct HeaderSection {
  build() {
    Row() {
      Column() {
        Text('Hello, Sophie')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTheme.onBackground)
        Text("Let's start learning!")
          .fontSize(16)
          .fontColor(AppTheme.gray)
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Row() {
        Text('🔔')
          .fontSize(24)
          .fontColor(AppTheme.onBackground)

        Stack() {
          Circle({ width: 48, height: 48 })
            .fill(AppTheme.primary20)
          Text('☺')
            .fontSize(24)
            .fontColor(AppTheme.primary)
        }
        .margin({ left: 8 })
      }
    }
    .padding(24)
  }
}

@Component
struct SearchBarSection {
  build() {
    Row() {
      Text('🔍')
        .fontSize(20)
        .fontColor(AppTheme.gray)

      Blank().width(16)

      Text('Search for course...')
        .fontColor(AppTheme.lightGray)
        .layoutWeight(1)

      Text('☰')
        .fontSize(20)
        .fontColor(AppTheme.primary)
    }
    .padding({ left: 16, right: 16 })
    .height(56)
    .backgroundColor('#FFFFFFFF')
    .borderRadius(16)
    .margin({ left: 24, right: 24 })
  }
}

@Component
struct OngoingCourseSection {
  build() {
    Column() {
      Text('Ongoing Course')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTheme.onBackground)

      Stack() {
        Column() {
          Row() {
            Column() {
              Text('3D Modeling')
                .fontSize(14)
                .fontColor(AppTheme.white70)

              Text('Blender Basic')
                .fontSize(22)
                .fontWeight(FontWeight.Bold)
                .fontColor('#FFFFFFFF')
                .margin({ top: 8 })

              Row() {
                Text('75%')
                  .fontSize(12)
                  .fontColor('#FFFFFFFF')

                Stack() {
                  Column() {
                    Blank()
                  }
                  .width('100%')
                  .height(6)
                  .backgroundColor(AppTheme.white20)
                  .borderRadius(4)

                  Column() {
                    Blank()
                  }
                  .width('75%')
                  .height(6)
                  .backgroundColor(AppTheme.progressColor)
                  .borderRadius(4)
                }
                .alignContent(Alignment.Start)
                .width('100%')
                .height(6)
                .margin({ left: 8 })
                .layoutWeight(1)
              }
              .margin({ top: 16 })
            }
            .alignItems(HorizontalAlign.Start)

            Blank()

            Stack() {
              Circle({ width: 60, height: 60 })
                .fill('#FFFFFFFF')
              Text('▶')
                .fontSize(32)
                .fontColor(AppTheme.primary)
            }
          }
          .padding(20)
          .alignItems(HorizontalAlign.Start)
        }
        .width('100%')
      }
      .backgroundColor(AppTheme.primary)
      .borderRadius(24)
      .height(140)
      .margin({ top: 16 })
    }
    .padding(24)
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct CategoriesSection {
  private categories: string[] = ['Coding', 'Design', 'Business', 'Photo', 'Music']

  build() {
    Scroll() {
      Row() {
        ForEach(this.categories, (category: string) => {
          Text(category)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(category === 'Design' ? '#FFFFFFFF' : AppTheme.gray)
            .padding({ left: 24, right: 24, top: 12, bottom: 12 })
            .backgroundColor(category === 'Design' ? AppTheme.selectedCategoryColor : '#FFFFFFFF')
            .borderRadius(12)
            .margin({ right: 12 })
        })
      }
      .padding({ left: 12, right: 12 })
    }
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
  }
}

@Component
struct RecommendedSection {
  build() {
    Column() {
      Row() {
        Text('Recommended')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTheme.onBackground)
        Blank()
        Text('See all')
          .fontColor(AppTheme.gray)
      }

      CourseCard({
        title: 'Mobile Dev', subtitle: 'Android Compose', rating: '4.9',
        bgColor: '#FFE3F2FC', accentColor: '#FF1466BF', iconName: '✓'
      })
      CourseCard({
        title: 'Photography', subtitle: 'Master Lighting', rating: '4.7',
        bgColor: '#FFFCE3ED', accentColor: '#FFC2175C', iconName: '★'
      })
      CourseCard({
        title: 'Finance', subtitle: 'Crypto Trading', rating: '4.5',
        bgColor: '#FFE8F5EB', accentColor: '#FF2E7D33', iconName: '★'
      })
    }
    .padding(24)
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct CourseCard {
  @Prop title: string = ''
  @Prop subtitle: string = ''
  @Prop rating: string = ''
  @Prop bgColor: string = '#FFFFFF'
  @Prop accentColor: string = '#FFFFFF'
  @Prop iconName: string = ''

  build() {
    Row() {
      Stack() {
        Text(this.iconName)
          .fontSize(32)
          .fontColor(this.accentColor)
      }
      .width(100)
      .height(100)
      .backgroundColor(this.bgColor)
      .borderRadius({ topLeft: 20, bottomLeft: 20 })

      Column() {
        Text(this.subtitle)
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTheme.primary)

        Text(this.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTheme.onBackground)
          .margin({ top: 4 })

        Row() {
          Text('★')
            .fontSize(12)
            .fontColor(AppTheme.starAmber)

          Text(this.rating)
            .fontSize(12)
            .fontColor(AppTheme.gray)
            .margin({ left: 4 })
        }
        .margin({ top: 4 })
      }
      .padding(16)
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Text('♥')
        .fontSize(20)
        .fontColor(AppTheme.heartGray)
        .margin({ right: 16 })
    }
    .height(100)
    .backgroundColor('#FFFFFFFF')
    .borderRadius(20)
    .margin({ top: 16 })
  }
}