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
          HeartIcon({ color: this.tint, size: 24 })
        } else if (this.iconType === 'calendar') {
          CalendarIcon({ color: this.tint, size: 24 })
        } else if (this.iconType === 'checkCircle') {
          CheckCircleIcon({ color: this.tint, size: 24 })
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
  color: string = '#FFE57373'
  size: number = 24

  build() {
    Shape() {
      Path()
        .commands(`M ${this.size * 0.5} ${this.size * 0.85}
                   C ${this.size * 0.1} ${this.size * 0.55}, 0 ${this.size * 0.35}, ${this.size * 0.25} ${this.size * 0.2}
                   C ${this.size * 0.4} ${this.size * 0.1}, ${this.size * 0.5} ${this.size * 0.25}, ${this.size * 0.5} ${this.size * 0.35}
                   C ${this.size * 0.5} ${this.size * 0.25}, ${this.size * 0.6} ${this.size * 0.1}, ${this.size * 0.75} ${this.size * 0.2}
                   C ${this.size} ${this.size * 0.35}, ${this.size * 0.9} ${this.size * 0.55}, ${this.size * 0.5} ${this.size * 0.85} Z`)
        .fill(this.color)
    }
    .width(this.size)
    .height(this.size)
  }
}

@Component
struct CalendarIcon {
  color: string = '#FF8D6E63'
  size: number = 24

  build() {
    Shape() {
      Path()
        .commands(`M ${this.size * 0.15} ${this.size * 0.25}
                   H ${this.size * 0.85}
                   V ${this.size * 0.9}
                   H ${this.size * 0.15}
                   Z
                   M ${this.size * 0.3} ${this.size * 0.1}
                   V ${this.size * 0.3}
                   M ${this.size * 0.7} ${this.size * 0.1}
                   V ${this.size * 0.3}
                   M ${this.size * 0.15} ${this.size * 0.45}
                   H ${this.size * 0.85}`)
        .stroke(this.color)
        .strokeWidth(1.5)
        .fill('transparent')
      Path()
        .commands(`M ${this.size * 0.15} ${this.size * 0.25}
                   H ${this.size * 0.85}
                   V ${this.size * 0.9}
                   H ${this.size * 0.15} Z`)
        .stroke(this.color)
        .strokeWidth(1.5)
        .fill('transparent')
    }
    .width(this.size)
    .height(this.size)
  }
}

@Component
struct CheckCircleIcon {
  color: string = '#FF64B5F6'
  size: number = 24

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Circle()
        .fill(this.color)
        .width(this.size)
        .height(this.size)

      Shape() {
        Path()
          .commands(`M ${this.size * 0.3} ${this.size * 0.5} L ${this.size * 0.45} ${this.size * 0.65} L ${this.size * 0.72} ${this.size * 0.35}`)
          .stroke(Color.White)
          .strokeWidth(2)
          .fill('transparent')
      }
      .width(this.size)
      .height(this.size)
    }
    .width(this.size)
    .height(this.size)
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
            .fontWeight(FontWeight.Light)
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
  private readonly iconColor: string = this.isSelected ? '#FF6A8E6A' : '#FFCFD8DC'

  build() {
    Column() {
      if (this.iconType === 'home') {
        HomeIcon({ color: this.iconColor, size: 28 })
      } else if (this.iconType === 'info') {
        InfoIcon({ color: this.iconColor, size: 28 })
      } else if (this.iconType === 'settings') {
        SettingsIcon({ color: this.iconColor, size: 28 })
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
  color: string = '#FF6A8E6A'
  size: number = 28

  build() {
    Shape() {
      Path()
        .commands(`M ${this.size * 0.5} ${this.size * 0.15}
                   L ${this.size * 0.1} ${this.size * 0.5}
                   L ${this.size * 0.25} ${this.size * 0.5}
                   L ${this.size * 0.25} ${this.size * 0.9}
                   L ${this.size * 0.42} ${this.size * 0.9}
                   L ${this.size * 0.42} ${this.size * 0.65}
                   L ${this.size * 0.58} ${this.size * 0.65}
                   L ${this.size * 0.58} ${this.size * 0.9}
                   L ${this.size * 0.75} ${this.size * 0.9}
                   L ${this.size * 0.75} ${this.size * 0.5}
                   L ${this.size * 0.9} ${this.size * 0.5}
                   Z`)
        .fill(this.color)
    }
    .width(this.size)
    .height(this.size)
  }
}

@Component
struct InfoIcon {
  color: string = '#FFCFD8DC'
  size: number = 28

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Circle()
        .fill(this.color)
        .width(this.size)
        .height(this.size)

      Column() {
        Text('i')
          .fontSize(this.size * 0.5)
          .fontColor(Color.White)
          .fontWeight(FontWeight.Bold)
          .fontStyle(FontStyle.Italic)
      }
      .width(this.size)
      .height(this.size)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
    }
    .width(this.size)
    .height(this.size)
  }
}

@Component
struct SettingsIcon {
  color: string = '#FFCFD8DC'
  size: number = 28

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Circle()
        .fill(this.color)
        .width(this.size * 0.35)
        .height(this.size * 0.35)

      Shape() {
        Path()
          .commands(`M ${this.size * 0.5} ${this.size * 0.05}
                     L ${this.size * 0.57} ${this.size * 0.2}
                     L ${this.size * 0.65} ${this.size * 0.18}
                     L ${this.size * 0.72} ${this.size * 0.3}
                     L ${this.size * 0.67} ${this.size * 0.38}
                     L ${this.size * 0.78} ${this.size * 0.45}
                     L ${this.size * 0.78} ${this.size * 0.55}
                     L ${this.size * 0.67} ${this.size * 0.62}
                     L ${this.size * 0.72} ${this.size * 0.7}
                     L ${this.size * 0.65} ${this.size * 0.82}
                     L ${this.size * 0.57} ${this.size * 0.8}
                     L ${this.size * 0.5} ${this.size * 0.95}
                     L ${this.size * 0.43} ${this.size * 0.8}
                     L ${this.size * 0.35} ${this.size * 0.82}
                     L ${this.size * 0.28} ${this.size * 0.7}
                     L ${this.size * 0.33} ${this.size * 0.62}
                     L ${this.size * 0.22} ${this.size * 0.55}
                     L ${this.size * 0.22} ${this.size * 0.45}
                     L ${this.size * 0.33} ${this.size * 0.38}
                     L ${this.size * 0.28} ${this.size * 0.3}
                     L ${this.size * 0.35} ${this.size * 0.18}
                     L ${this.size * 0.43} ${this.size * 0.2}
                     Z`)
          .fill(this.color)
      }
      .width(this.size)
      .height(this.size)
    }
    .width(this.size)
    .height(this.size)
  }
}

@Component
struct BonsaiVisual {
  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Canvas() {
        const w = 220
        const h = 220
        const ZenGreen = '#FF6A8E6A'
        const ZenBrown = '#FF8D6E63'
        const TrunkBrown = '#FF5D4037'

        const potWidth = w * 0.5
        const potHeight = h * 0.15
        const potTop = h * 0.85
        const potLeft = (w - potWidth) / 2

        Rect({ width: potWidth, height: potHeight })
          .fill(ZenBrown)
          .position({ x: potLeft, y: potTop })

        Rect({ width: potWidth + 20, height: 15 })
          .fill('#FF7A5D53')
          .position({ x: potLeft - 10, y: potTop })

        Path()
          .commands(`M ${w * 0.5} ${potTop} Q ${w * 0.45} ${h * 0.6} ${w * 0.35} ${h * 0.5} Q ${w * 0.4} ${h * 0.35} ${w * 0.6} ${h * 0.3}`)
          .stroke(TrunkBrown)
          .strokeWidth(25)
          .strokeLineCap(LineCapStyle.Round)
          .fill('transparent')

        Path()
          .commands(`M ${w * 0.38} ${h * 0.55} L ${w * 0.25} ${h * 0.45}`)
          .stroke(TrunkBrown)
          .strokeWidth(15)
          .strokeLineCap(LineCapStyle.Round)
          .fill('transparent')

        Circle({ width: 90, height: 90 })
          .fill(ZenGreen)
          .position({ x: w * 0.6 - 45, y: h * 0.25 - 45 })
        Circle({ width: 70, height: 70 })
          .fill('#AA6A8E6A')
          .position({ x: w * 0.68 - 35, y: h * 0.28 - 35 })
        Circle({ width: 60, height: 60 })
          .fill('#E66A8E6A')
          .position({ x: w * 0.55 - 30, y: h * 0.22 - 30 })

        Circle({ width: 70, height: 70 })
          .fill(ZenGreen)
          .position({ x: w * 0.35 - 35, y: h * 0.5 - 35 })
        Circle({ width: 50, height: 50 })
          .fill('#CC6A8E6A')
          .position({ x: w * 0.30 - 25, y: h * 0.45 - 25 })

        Circle({ width: 50, height: 50 })
          .fill(ZenGreen)
          .position({ x: w * 0.22 - 25, y: h * 0.42 - 25 })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}
