@Entry
@Component
struct ZenBonsaiApp {
  build() {
    Column() {
      Column() {
        HeaderSection()

        BonsaiVisual()
          .width(220)
          .height(220)
          .margin({ top: 32 })

        StatusRow()
          .margin({ top: 32 })

        ActivityLogSection()
          .margin({ top: 32 })
      }
      .width('100%')
      .padding(24)
      .layoutWeight(1)

      SimpleBottomNav()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFFFF')
  }
}

@Component
struct HeaderSection {
  build() {
    Column() {
      Text('JUNIPER · #04')
        .fontSize(14)
        .fontColor('#FF7F8C8D')
        .letterSpacing(2)

      Text('Zen Garden')
        .fontSize(48)
        .fontWeight(FontWeight.Lighter)
        .fontColor('#FF2C3E50')
        .margin({ top: 8 })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct StatusRow {
  build() {
    Row() {
      StatusItem({
        iconType: 'heart',
        label: 'Health',
        value: '98%',
        tint: '#FFE57373'
      })
      .layoutWeight(1)

      StatusItem({
        iconType: 'calendar',
        label: 'Age',
        value: '4 Yrs',
        tint: '#FF8D6E63'
      })
      .layoutWeight(1)

      StatusItem({
        iconType: 'checkCircle',
        label: 'Water',
        value: '2 Days',
        tint: '#FF64B5F6'
      })
      .layoutWeight(1)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceEvenly)
  }
}

@Component
struct StatusItem {
  iconType: string = ''
  label: string = ''
  value: string = ''
  tint: string = ''

  build() {
    Column() {
      Stack({ alignContent: Alignment.Center }) {
        Circle({ width: 50, height: 50 })
          .fill('#FFF7F9F9')
          .stroke('#FFECEFF1')
          .strokeWidth(1)

        if (this.iconType === 'heart') {
          HeartIcon({ iconColor: this.tint, iconSize: 24 })
        } else if (this.iconType === 'calendar') {
          CalendarIcon({ iconColor: this.tint, iconSize: 24 })
        } else if (this.iconType === 'checkCircle') {
          CheckCircleIcon({ iconColor: this.tint, iconSize: 24 })
        }
      }
      .width(50)
      .height(50)

      Text(this.value)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#FF2C3E50')
        .margin({ top: 8 })

      Text(this.label)
        .fontSize(12)
        .fontColor('#FF7F8C8D')
    }
    .width('100%')
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct HeartIcon {
  iconColor: string = '#FFE57373'
  iconSize: number = 24

  build() {
    Shape() {
      Path()
        .commands(`M ${this.iconSize * 0.5} ${this.iconSize * 0.85}
                   C ${this.iconSize * 0.1} ${this.iconSize * 0.55}, 0 ${this.iconSize * 0.35}, ${this.iconSize * 0.25} ${this.iconSize * 0.2}
                   C ${this.iconSize * 0.4} ${this.iconSize * 0.1}, ${this.iconSize * 0.5} ${this.iconSize * 0.25}, ${this.iconSize * 0.5} ${this.iconSize * 0.35}
                   C ${this.iconSize * 0.5} ${this.iconSize * 0.25}, ${this.iconSize * 0.6} ${this.iconSize * 0.1}, ${this.iconSize * 0.75} ${this.iconSize * 0.2}
                   C ${this.iconSize} ${this.iconSize * 0.35}, ${this.iconSize * 0.9} ${this.iconSize * 0.55}, ${this.iconSize * 0.5} ${this.iconSize * 0.85} Z`)
        .fill(this.iconColor)
    }
    .width(this.iconSize)
    .height(this.iconSize)
  }
}

@Component
struct CalendarIcon {
  iconColor: string = '#FF8D6E63'
  iconSize: number = 24

  build() {
    Shape() {
      Path()
        .commands(`M ${this.iconSize * 0.15} ${this.iconSize * 0.25}
                   H ${this.iconSize * 0.85}
                   V ${this.iconSize * 0.9}
                   H ${this.iconSize * 0.15}
                   Z
                   M ${this.iconSize * 0.3} ${this.iconSize * 0.1}
                   V ${this.iconSize * 0.3}
                   M ${this.iconSize * 0.7} ${this.iconSize * 0.1}
                   V ${this.iconSize * 0.3}
                   M ${this.iconSize * 0.15} ${this.iconSize * 0.45}
                   H ${this.iconSize * 0.85}`)
        .stroke(this.iconColor)
        .strokeWidth(1.5)
        .fill('transparent')
    }
    .width(this.iconSize)
    .height(this.iconSize)
  }
}

@Component
struct CheckCircleIcon {
  iconColor: string = '#FF64B5F6'
  iconSize: number = 24

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Circle()
        .fill(this.iconColor)
        .width(this.iconSize)
        .height(this.iconSize)

      Shape() {
        Path()
          .commands(`M ${this.iconSize * 0.3} ${this.iconSize * 0.5} L ${this.iconSize * 0.45} ${this.iconSize * 0.65} L ${this.iconSize * 0.72} ${this.iconSize * 0.35}`)
          .stroke(Color.White)
          .strokeWidth(2)
          .fill('transparent')
      }
      .width(this.iconSize)
      .height(this.iconSize)
    }
    .width(this.iconSize)
    .height(this.iconSize)
  }
}

@Component
struct ActivityLogSection {
  build() {
    Column() {
      Row() {
        Text('Care Schedule')
          .fontSize(18)
          .fontWeight(600)
          .fontColor('#FF2C3E50')
          .layoutWeight(1)

        Stack({ alignContent: Alignment.Center }) {
          Circle()
            .fill('#FFE8F5E9')
            .width(28)
            .height(28)

          Text('+')
            .fontSize(20)
            .fontColor('#FF6A8E6A')
            .fontWeight(FontWeight.Lighter)
        }
        .width(28)
        .height(28)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Column({ space: 12 }) {
        CareLogItem({ title: 'Watering', subtitle: 'Today, 8:00 AM', isDone: true })
        CareLogItem({ title: 'Pruning', subtitle: 'Tomorrow', isDone: false })
        CareLogItem({ title: 'Fertilizer', subtitle: 'In 5 days', isDone: false })
      }
      .width('100%')
      .margin({ top: 16 })
    }
    .width('100%')
  }
}

@Component
struct CareLogItem {
  title: string = ''
  subtitle: string = ''
  isDone: boolean = false

  build() {
    Row() {
      Circle()
        .fill(this.isDone ? '#FF6A8E6A' : '#FFE0E0E0')
        .width(12)
        .height(12)

      Column() {
        Text(this.title)
          .fontSize(14)
          .fontColor(this.isDone ? '#FF2C3E50' : '#FF7F8C8D')

        Text(this.subtitle)
          .fontSize(12)
          .fontColor('#FF9E9E9E')
          .margin({ top: 2 })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .margin({ left: 16 })

      if (this.isDone) {
        Shape() {
          Path()
            .commands('M 3 10 L 8 15 L 17 5')
            .stroke('#FF6A8E6A')
            .strokeWidth(2)
            .fill('transparent')
        }
        .width(20)
        .height(20)
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFAFAFA')
    .borderRadius(12)
    .border({ width: 1, color: '#FFF0F0F0' })
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct SimpleBottomNav {
  build() {
    Row() {
      NavIcon({ iconType: 'home', isSelected: true })
        .layoutWeight(1)

      NavIcon({ iconType: 'info', isSelected: false })
        .layoutWeight(1)

      NavIcon({ iconType: 'settings', isSelected: false })
        .layoutWeight(1)
    }
    .width('100%')
    .height(80)
    .backgroundColor('#FFFFFFFF')
    .border({ width: 1, color: '#FFF5F5F5' })
    .justifyContent(FlexAlign.SpaceAround)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct NavIcon {
  iconType: string = ''
  isSelected: boolean = false

  aboutToAppear() {}

  build() {
    Column() {
      if (this.iconType === 'home') {
        HomeIcon({ iconColor: this.isSelected ? '#FF6A8E6A' : '#FFCFD8DC', iconSize: 28 })
      } else if (this.iconType === 'info') {
        InfoIcon({ iconColor: this.isSelected ? '#FF6A8E6A' : '#FFCFD8DC', iconSize: 28 })
      } else if (this.iconType === 'settings') {
        SettingsIcon({ iconColor: this.isSelected ? '#FF6A8E6A' : '#FFCFD8DC', iconSize: 28 })
      }

      if (this.isSelected) {
        Circle()
          .fill('#FF6A8E6A')
          .width(4)
          .height(4)
          .margin({ top: 4 })
      }
    }
    .width('100%')
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct HomeIcon {
  iconColor: string = '#FF6A8E6A'
  iconSize: number = 28

  build() {
    Shape() {
      Path()
        .commands(`M ${this.iconSize * 0.5} ${this.iconSize * 0.15}
                   L ${this.iconSize * 0.1} ${this.iconSize * 0.5}
                   L ${this.iconSize * 0.25} ${this.iconSize * 0.5}
                   L ${this.iconSize * 0.25} ${this.iconSize * 0.9}
                   L ${this.iconSize * 0.42} ${this.iconSize * 0.9}
                   L ${this.iconSize * 0.42} ${this.iconSize * 0.65}
                   L ${this.iconSize * 0.58} ${this.iconSize * 0.65}
                   L ${this.iconSize * 0.58} ${this.iconSize * 0.9}
                   L ${this.iconSize * 0.75} ${this.iconSize * 0.9}
                   L ${this.iconSize * 0.75} ${this.iconSize * 0.5}
                   L ${this.iconSize * 0.9} ${this.iconSize * 0.5}
                   Z`)
        .fill(this.iconColor)
    }
    .width(this.iconSize)
    .height(this.iconSize)
  }
}

@Component
struct InfoIcon {
  iconColor: string = '#FFCFD8DC'
  iconSize: number = 28

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Circle()
        .fill(this.iconColor)
        .width(this.iconSize)
        .height(this.iconSize)

      Text('i')
        .fontSize(this.iconSize * 0.5)
        .fontColor(Color.White)
        .fontWeight(FontWeight.Bold)
        .fontStyle(FontStyle.Italic)
    }
    .width(this.iconSize)
    .height(this.iconSize)
  }
}

@Component
struct SettingsIcon {
  iconColor: string = '#FFCFD8DC'
  iconSize: number = 28

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Shape() {
        Path()
          .commands(`M ${this.iconSize * 0.5} ${this.iconSize * 0.05}
                     L ${this.iconSize * 0.57} ${this.iconSize * 0.2}
                     L ${this.iconSize * 0.65} ${this.iconSize * 0.18}
                     L ${this.iconSize * 0.72} ${this.iconSize * 0.3}
                     L ${this.iconSize * 0.67} ${this.iconSize * 0.38}
                     L ${this.iconSize * 0.78} ${this.iconSize * 0.45}
                     L ${this.iconSize * 0.78} ${this.iconSize * 0.55}
                     L ${this.iconSize * 0.67} ${this.iconSize * 0.62}
                     L ${this.iconSize * 0.72} ${this.iconSize * 0.7}
                     L ${this.iconSize * 0.65} ${this.iconSize * 0.82}
                     L ${this.iconSize * 0.57} ${this.iconSize * 0.8}
                     L ${this.iconSize * 0.5} ${this.iconSize * 0.95}
                     L ${this.iconSize * 0.43} ${this.iconSize * 0.8}
                     L ${this.iconSize * 0.35} ${this.iconSize * 0.82}
                     L ${this.iconSize * 0.28} ${this.iconSize * 0.7}
                     L ${this.iconSize * 0.33} ${this.iconSize * 0.62}
                     L ${this.iconSize * 0.22} ${this.iconSize * 0.55}
                     L ${this.iconSize * 0.22} ${this.iconSize * 0.45}
                     L ${this.iconSize * 0.33} ${this.iconSize * 0.38}
                     L ${this.iconSize * 0.28} ${this.iconSize * 0.3}
                     L ${this.iconSize * 0.35} ${this.iconSize * 0.18}
                     L ${this.iconSize * 0.43} ${this.iconSize * 0.2}
                     Z`)
          .fill(this.iconColor)
      }
      .width(this.iconSize)
      .height(this.iconSize)

      Circle()
        .fill(Color.White)
        .width(this.iconSize * 0.35)
        .height(this.iconSize * 0.35)
    }
    .width(this.iconSize)
    .height(this.iconSize)
  }
}

@Component
struct BonsaiVisual {
  private readonly canvasW: number = 220
  private readonly canvasH: number = 220
  private readonly ZenGreen: string = '#FF6A8E6A'
  private readonly ZenBrown: string = '#FF8D6E63'
  private readonly TrunkBrown: string = '#FF5D4037'
  private readonly potWidth: number = 110
  private readonly potHeight: number = 33
  private readonly potTop: number = 187
  private readonly potLeft: number = 55

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Canvas() {
        Rect({ width: 110, height: 33 })
          .fill(this.ZenBrown)
          .position({ x: 55, y: 187 })

        Rect({ width: 130, height: 15 })
          .fill('#FF7A5D53')
          .position({ x: 45, y: 187 })

        Path()
          .commands('M 110 187 Q 99 132 77 110 Q 88 77 132 66')
          .stroke(this.TrunkBrown)
          .strokeWidth(25)
          .strokeLineCap(LineCapStyle.Round)
          .fill('transparent')

        Path()
          .commands('M 83.6 121 L 55 99')
          .stroke(this.TrunkBrown)
          .strokeWidth(15)
          .strokeLineCap(LineCapStyle.Round)
          .fill('transparent')

        Circle({ width: 90, height: 90 })
          .fill(this.ZenGreen)
          .position({ x: 87, y: 10 })
        Circle({ width: 70, height: 70 })
          .fill('#AA6A8E6A')
          .position({ x: 114.6, y: 26.6 })
        Circle({ width: 60, height: 60 })
          .fill('#E66A8E6A')
          .position({ x: 91, y: 18.4 })

        Circle({ width: 70, height: 70 })
          .fill(this.ZenGreen)
          .position({ x: 42, y: 75 })
        Circle({ width: 50, height: 50 })
          .fill('#CC6A8E6A')
          .position({ x: 41, y: 74 })

        Circle({ width: 50, height: 50 })
          .fill(this.ZenGreen)
          .position({ x: 23.4, y: 67.4 })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}
