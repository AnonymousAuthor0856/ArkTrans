class Course {
  title: string;
  subtitle: string;
  rating: string;
  bgColor: string;
  accentColor: string;

  constructor(title: string, subtitle: string, rating: string, bgColor: string, accentColor: string) {
    this.title = title;
    this.subtitle = subtitle;
    this.rating = rating;
    this.bgColor = bgColor;
    this.accentColor = accentColor;
  }
}

@Entry
@Component
struct CourseDashboardScreen {
  private categories: string[] = ["Coding", "Design", "Business", "Photo", "Music"];
  private courses: Course[] = [
    new Course("Mobile Dev", "Android Compose", "4.9", "#E3F2FD", "#1565C0"),
    new Course("Photography", "Master Lighting", "4.7", "#FCE4EC", "#C2185B"),
    new Course("Finance", "Crypto Trading", "4.5", "#E8F5E9", "#2E7D32")
  ];

  build() {
    Stack() {
      Scroll() {
        Column() {
          this.HeaderSection()
          this.SearchBarSection()
          this.OngoingCourseSection()
          this.CategoriesSection()
          this.RecommendedSection()
        }
        .width('100%')
        .padding({ bottom: 80 })
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)

      this.BottomNavigationBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F7')
    .alignContent(Alignment.Bottom)
  }

  @Builder
  HeaderSection() {
    Row() {
      Column() {
        Text("Hello, Sophie")
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1C1B1F')
        Text("Let's start learning!")
          .fontSize(16)
          .fontColor('#888888')
      }
      .alignItems(HorizontalAlign.Start)

      Row() {
        Text("🔔")
          .fontSize(22)
          .fontColor('#1C1B1F')

        Column() {
          Text("👤")
            .fontSize(22)
            .fontColor('#4E31AA')
        }
        .width(48)
        .height(48)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .borderRadius(24)
        .backgroundColor('#334E31AA')
        .margin({ left: 8 })
      }
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .padding(24)
  }

  @Builder
  SearchBarSection() {
    Row() {
      Row() {
        Text("🔍")
          .fontSize(22)
          .fontColor('#888888')
        Text("Search for course...")
          .fontSize(14)
          .fontColor('#CCCCCC')
          .margin({ left: 16 })
        Blank()
        Text("⚙️")
          .fontSize(22)
          .fontColor('#4E31AA')
      }
      .width('100%')
      .height(56)
      .alignItems(VerticalAlign.Center)
      .backgroundColor('#FFFFFF')
      .borderRadius(16)
      .padding({ left: 16, right: 16 })
    }
    .width('100%')
    .padding({ left: 24, right: 24 })
  }

  @Builder
  OngoingCourseSection() {
    Column() {
      Text("Ongoing Course")
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1C1B1F')

      Row() {
        Column() {
          Text("3D Modeling")
            .fontSize(14)
            .fontColor('#B3FFFFFF')
          Text("Blender Basic")
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFFFFF')
            .margin({ top: 8 })
          Row() {
            Text("75%")
              .fontSize(12)
              .fontColor('#FFFFFF')
            Progress({ value: 75, total: 100, type: ProgressType.Linear })
              .layoutWeight(1)
              .height(6)
              .color('#FFA726')
              .backgroundColor('#33FFFFFF')
              .borderRadius(4)
              .margin({ left: 8 })
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)
          .margin({ top: 16 })
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)

        Column() {
          Text("▶")
            .fontSize(32)
            .fontColor('#4E31AA')
        }
        .width(60)
        .height(60)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .borderRadius(30)
        .backgroundColor('#FFFFFF')
        .margin({ left: 16 })
      }
      .width('100%')
      .height(140)
      .alignItems(VerticalAlign.Center)
      .backgroundColor('#4E31AA')
      .borderRadius(24)
      .padding(20)
      .margin({ top: 16 })
    }
    .width('100%')
    .padding(24)
  }

  @Builder
  CategoriesSection() {
    Scroll() {
      Row({ space: 12 }) {
        ForEach(this.categories, (cat: string) => {
          Text(cat)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(cat === "Design" ? '#FFFFFF' : '#888888')
            .padding({ left: 24, right: 24, top: 12, bottom: 12 })
            .backgroundColor(cat === "Design" ? '#FF7043' : '#FFFFFF')
            .borderRadius(12)
        }, (cat: string) => cat)
      }
      .padding({ left: 24, right: 24 })
    }
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
    .width('100%')
  }

  @Builder
  RecommendedSection() {
    Column({ space: 16 }) {
      Row() {
        Text("Recommended")
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1C1B1F')
        Text("See all")
          .fontSize(14)
          .fontColor('#888888')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      ForEach(this.courses, (course: Course) => {
        this.CourseCard(course)
      }, (course: Course) => course.title)
    }
    .width('100%')
    .padding(24)
  }

  @Builder
  CourseCard(course: Course) {
    Row() {
      Column() {
        Text(course.title.includes("Mobile") ? "✔" : "★")
          .fontSize(32)
          .fontColor(course.accentColor)
      }
      .width(100)
      .height('100%')
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .backgroundColor(course.bgColor)
      .borderRadius({ topLeft: 20, topRight: 0, bottomLeft: 20, bottomRight: 0 })

      Column() {
        Text(course.subtitle)
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor('#4E31AA')
        Text(course.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1C1B1F')
        Row() {
          Text("★")
            .fontSize(16)
            .fontColor('#FFB300')
          Text(course.rating)
            .fontSize(12)
            .fontColor('#888888')
            .margin({ left: 4 })
        }
        .alignItems(VerticalAlign.Center)
        .margin({ top: 4 })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .padding(16)

      Text("♥")
        .fontSize(22)
        .fontColor('#EEEEEE')
        .margin({ right: 16 })
    }
    .width('100%')
    .height(100)
    .alignItems(VerticalAlign.Center)
    .backgroundColor('#FFFFFF')
    .borderRadius(20)
  }

  @Builder
  BottomNavigationBar() {
    Row() {
      Text("🏠")
        .fontSize(22)
        .fontColor('#FFFFFF')
      Text("🔍")
        .fontSize(22)
        .fontColor('#888888')
      Text("♥")
        .fontSize(22)
        .fontColor('#888888')
      Text("👤")
        .fontSize(22)
        .fontColor('#888888')
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceEvenly)
    .padding({ top: 16, bottom: 16 })
    .backgroundColor('#1E1E1E')
    .borderRadius(32)
    .margin(24)
  }
}
