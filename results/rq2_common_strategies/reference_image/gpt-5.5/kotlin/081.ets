@Entry
@Component
struct FurnitureDetailScreen {
  build() {
    Column() {
      HeaderBar()

      Blank()
        .height(24)

      ProductImagePlaceholder()

      Blank()
        .height(32)

      ProductInfoSection()

      Blank()
        .layoutWeight(1)

      BottomActionSection()
    }
    .width('100%')
    .height('100%')
    .padding({ left: 24, right: 24, top: 24, bottom: 24 })
    .backgroundColor(Color.White)
  }
}

@Component
struct HeaderBar {
  build() {
    Row() {
      Stack({ alignContent: Alignment.Center }) {
        Text('←')
          .fontSize(34)
          .fontColor(Color.Black)
      }
      .width(48)
      .height(48)
      .border({
        width: 1,
        color: '#E0E0E0',
        radius: 24
      })
      .onClick(() => {
      })

      Text('Details')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)

      Stack({ alignContent: Alignment.Center }) {
        Text('♡')
          .fontSize(38)
          .fontColor(Color.Black)
      }
      .width(48)
      .height(48)
      .border({
        width: 1,
        color: '#E0E0E0',
        radius: 24
      })
      .onClick(() => {
      })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct ProductImagePlaceholder {
  build() {
    Stack({ alignContent: Alignment.Center }) {
      CartCanvasIcon({ iconSize: 88, iconColor: '#BDBDBD' })
    }
    .width('100%')
    .height(300)
    .borderRadius(32)
    .backgroundColor('#F5F5F5')
  }
}

@Component
struct CartCanvasIcon {
  @Prop iconSize: number = 80
  @Prop iconColor: string = '#BDBDBD'

  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  drawCart() {
    const scale: number = this.iconSize / 80
    this.context.clearRect(0, 0, this.iconSize, this.iconSize)
    this.context.fillStyle = this.iconColor

    this.context.beginPath()
    this.context.moveTo(17 * scale, 20 * scale)
    this.context.lineTo(28 * scale, 20 * scale)
    this.context.lineTo(34 * scale, 31 * scale)
    this.context.lineTo(67 * scale, 31 * scale)
    this.context.lineTo(71 * scale, 34 * scale)
    this.context.lineTo(61 * scale, 54 * scale)
    this.context.lineTo(37 * scale, 54 * scale)
    this.context.lineTo(27 * scale, 25 * scale)
    this.context.lineTo(17 * scale, 25 * scale)
    this.context.closePath()
    this.context.fill()

    this.context.beginPath()
    this.context.moveTo(36 * scale, 56 * scale)
    this.context.lineTo(62 * scale, 56 * scale)
    this.context.lineTo(62 * scale, 63 * scale)
    this.context.lineTo(32 * scale, 63 * scale)
    this.context.lineTo(36 * scale, 56 * scale)
    this.context.closePath()
    this.context.fill()

    this.context.beginPath()
    this.context.arc(35 * scale, 70 * scale, 6 * scale, 0, Math.PI * 2)
    this.context.fill()

    this.context.beginPath()
    this.context.arc(61 * scale, 70 * scale, 6 * scale, 0, Math.PI * 2)
    this.context.fill()
  }

  build() {
    Canvas(this.context)
      .width(this.iconSize)
      .height(this.iconSize)
      .onReady(() => {
        this.drawCart()
      })
  }
}

@Component
struct ProductInfoSection {
  build() {
    Column() {
      Row() {
        Column() {
          Text('Modern Lounge Chair')
            .fontSize(26)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
            .lineHeight(32)

          Blank()
            .height(8)

          Text('Minimalist Series')
            .fontSize(16)
            .fontColor(Color.Gray)
        }
        .layoutWeight(1)
        .margin({ right: 16 })

        Text('$1299')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Top)

      Blank()
        .height(24)

      Row() {
        Text('★')
          .fontSize(22)
          .fontColor('#FFC107')

        Blank()
          .width(4)

        Text('4.8')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)

        Blank()
          .width(8)

        Text('(238 Reviews)')
          .fontSize(14)
          .fontColor(Color.Gray)
      }
      .alignItems(VerticalAlign.Center)

      Blank()
        .height(24)

      Text('Colors')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)

      Blank()
        .height(12)

      Row({ space: 12 }) {
        ColorSelector({ selectorColor: '#212121', isSelected: true })
        ColorSelector({ selectorColor: '#795548', isSelected: false })
        ColorSelector({ selectorColor: '#9E9E9E', isSelected: false })
      }
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct ColorSelector {
  @Prop selectorColor: ResourceColor = Color.Black
  @Prop isSelected: boolean = false

  build() {
    Stack({ alignContent: Alignment.Center }) {
      if (this.isSelected) {
        Stack()
          .width(10)
          .height(10)
          .borderRadius(5)
          .backgroundColor(Color.White)
      }
    }
    .width(32)
    .height(32)
    .borderRadius(16)
    .backgroundColor(this.selectorColor)
    .border({
      width: this.isSelected ? 2 : 0,
      color: '#D3D3D3',
      radius: 16
    })
  }
}

@Component
struct BottomActionSection {
  build() {
    Row({ space: 16 }) {
      Button('Add to Cart', { type: ButtonType.Normal })
        .height(56)
        .layoutWeight(1)
        .borderRadius(16)
        .backgroundColor(Color.Black)
        .fontColor(Color.White)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .stateEffect(true)
        .onClick(() => {
        })

      Stack({ alignContent: Alignment.Center }) {
        Text('♥')
          .fontSize(28)
          .fontColor(Color.Black)
      }
      .width(56)
      .height(56)
      .borderRadius(16)
      .backgroundColor('#F5F5F5')
      .onClick(() => {
      })
    }
    .width('100%')
  }
}