@Entry
@Component
struct Index {
  build() {
    ServerStatusScreen()
  }
}

@Component
struct ServerStatusScreen {
  build() {
    Column() {
      TopBar()
        .padding({ top: 48, left: 24, right: 24, bottom: 16 })

      Scroll() {
        Column() {
          HeroStatusCard()
            .margin({ top: 16, bottom: 16 })

          Text('Control Panel')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')
            .width('100%')
            .margin({ bottom: 16 })

          Row({ space: 16 }) {
            ActionButton({
              icon: 'play',
              label: 'Start',
              bgColor: '#E3F2FD',
              iconColor: '#2196F3'
            })
              .layoutWeight(1)

            ActionButton({
              icon: 'reboot',
              label: 'Reboot',
              bgColor: '#FFF3E0',
              iconColor: '#FF9800'
            })
              .layoutWeight(1)

            ActionButton({
              icon: 'lock',
              label: 'Lock',
              bgColor: '#FFEBEE',
              iconColor: '#F44336'
            })
              .layoutWeight(1)

            ActionButton({
              icon: 'gear',
              label: 'Config',
              bgColor: '#F3E5F5',
              iconColor: '#9C27B0'
            })
              .layoutWeight(1)
          }
          .width('100%')
          .margin({ bottom: 32 })

          Row() {
            Text('Recent Logs')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor('#000000')

            Blank()

            Text('View All')
              .fontSize(14)
              .fontWeight(FontWeight.SemiBold)
              .fontColor('#2196F3')
          }
          .width('100%')
          .margin({ bottom: 8 })

          Column({ space: 12 }) {
            LogItem({
              icon: 'warning',
              title: 'High Memory Usage',
              time: '10:42 AM',
              bgColor: '#FFF3E0',
              iconColor: '#FF9800'
            })

            LogItem({
              icon: 'person',
              title: 'Admin Login: root',
              time: '09:15 AM',
              bgColor: '#E3F2FD',
              iconColor: '#2196F3'
            })

            LogItem({
              icon: 'info',
              title: 'Backup Completed',
              time: '04:00 AM',
              bgColor: '#E8F5E9',
              iconColor: '#4CAF50'
            })
          }
          .width('100%')
          .margin({ bottom: 16 })
        }
        .width('100%')
        .padding({ left: 24, right: 24 })
        .alignItems(HorizontalAlign.Start)
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}

@Component
struct TopBar {
  build() {
    Stack({ alignContent: Alignment.Center }) {
      Row() {
        Stack({ alignContent: Alignment.Center }) {
          IconCanvas({ icon: 'menu', color: '#000000', size: 28 })
        }
        .width(36)
        .height(36)
        .onClick(() => {
        })

        Blank()

        Stack({ alignContent: Alignment.TopEnd }) {
          IconCanvas({ icon: 'bell', color: '#000000', size: 30 })

          Stack()
            .width(10)
            .height(10)
            .borderRadius(5)
            .backgroundColor('#F44336')
            .margin({ top: 0, right: 0 })
        }
        .width(38)
        .height(38)
        .onClick(() => {
        })
      }
      .width('100%')
      .height(40)

      Text('NodeLink')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')
    }
    .width('100%')
    .height(40)
  }
}

@Component
struct HeroStatusCard {
  build() {
    Column() {
      Stack({ alignContent: Alignment.Center }) {
        Stack()
          .width(100)
          .height(100)
          .borderRadius(50)
          .backgroundColor('#FFFFFF')

        Stack({ alignContent: Alignment.Center }) {
          Stack()
            .width(84)
            .height(84)
            .borderRadius(42)
            .backgroundColor('#E8F5E9')

          IconCanvas({ icon: 'check', color: '#4CAF50', size: 56 })
        }
        .width(84)
        .height(84)
      }
      .width(100)
      .height(100)

      Text('System Operational')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')
        .margin({ top: 16 })

      Text('Uptime: 14d 2h 15m')
        .fontSize(14)
        .fontColor('#8E8E93')
        .margin({ top: 4 })

      Row() {
        StatBadge({ label: 'CPU', value: '12%' })
          .layoutWeight(1)

        StatBadge({ label: 'RAM', value: '4.2GB' })
          .layoutWeight(1)

        StatBadge({ label: 'NET', value: '1Gbps' })
          .layoutWeight(1)
      }
      .width('100%')
      .margin({ top: 24 })
    }
    .width('100%')
    .padding(24)
    .borderRadius(24)
    .backgroundColor('#F5F7FA')
  }
}

@Component
struct StatBadge {
  label: string = ''
  value: string = ''

  build() {
    Column({ space: 2 }) {
      Text(this.value)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')

      Text(this.label)
        .fontSize(12)
        .fontColor('#8E8E93')
    }
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct ActionButton {
  icon: string = ''
  label: string = ''
  bgColor: string = '#FFFFFF'
  iconColor: string = '#000000'

  build() {
    Column() {
      Stack({ alignContent: Alignment.Center }) {
        IconCanvas({ icon: this.icon, color: this.iconColor, size: 34 })
      }
      .width('100%')
      .height(64)
      .borderRadius(16)
      .backgroundColor(this.bgColor)
      .onClick(() => {
      })

      Text(this.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
        .margin({ top: 8 })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct LogItem {
  icon: string = ''
  title: string = ''
  time: string = ''
  bgColor: string = '#FFFFFF'
  iconColor: string = '#000000'

  build() {
    Row() {
      Stack({ alignContent: Alignment.Center }) {
        IconCanvas({ icon: this.icon, color: this.iconColor, size: 24 })
      }
      .width(40)
      .height(40)
      .borderRadius(20)
      .backgroundColor(this.bgColor)

      Text(this.title)
        .fontSize(14)
        .fontWeight(FontWeight.SemiBold)
        .fontColor('#000000')
        .margin({ left: 16 })

      Blank()

      Text(this.time)
        .fontSize(12)
        .fontColor('#8E8E93')
    }
    .width('100%')
    .padding({ top: 4, bottom: 4 })
    .backgroundColor('#FFFFFF')
  }
}

@Component
struct IconCanvas {
  icon: string = 'menu'
  color: string = '#000000'
  size: number = 24

  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  build() {
    Canvas(this.canvasContext)
      .width(this.size)
      .height(this.size)
      .onReady(() => {
        this.drawIcon()
      })
  }

  private drawIcon(): void {
    let ctx = this.canvasContext
    ctx.clearRect(0, 0, this.size, this.size)
    ctx.save()
    ctx.scale(this.size / 64, this.size / 64)
    ctx.fillStyle = this.color
    ctx.strokeStyle = this.color
    ctx.lineWidth = 6
    ctx.lineCap = 'round'
    ctx.lineJoin = 'round'

    if (this.icon === 'menu') {
      this.drawMenu(ctx)
    } else if (this.icon === 'bell') {
      this.drawBell(ctx)
    } else if (this.icon === 'check') {
      this.drawCheck(ctx)
    } else if (this.icon === 'play') {
      this.drawPlay(ctx)
    } else if (this.icon === 'reboot') {
      this.drawReboot(ctx)
    } else if (this.icon === 'lock') {
      this.drawLock(ctx)
    } else if (this.icon === 'gear') {
      this.drawGear(ctx)
    } else if (this.icon === 'warning') {
      this.drawWarning(ctx)
    } else if (this.icon === 'person') {
      this.drawPerson(ctx)
    } else if (this.icon === 'info') {
      this.drawInfo(ctx)
    }

    ctx.restore()
  }

  private drawMenu(ctx: CanvasRenderingContext2D): void {
    ctx.lineWidth = 6
    ctx.beginPath()
    ctx.moveTo(10, 18)
    ctx.lineTo(54, 18)
    ctx.moveTo(10, 32)
    ctx.lineTo(54, 32)
    ctx.moveTo(10, 46)
    ctx.lineTo(54, 46)
    ctx.stroke()
  }

  private drawBell(ctx: CanvasRenderingContext2D): void {
    ctx.beginPath()
    ctx.moveTo(20, 50)
    ctx.lineTo(44, 50)
    ctx.quadraticCurveTo(48, 50, 48, 46)
    ctx.lineTo(44, 40)
    ctx.lineTo(44, 26)
    ctx.quadraticCurveTo(44, 14, 32, 14)
    ctx.quadraticCurveTo(20, 14, 20, 26)
    ctx.lineTo(20, 40)
    ctx.lineTo(16, 46)
    ctx.quadraticCurveTo(16, 50, 20, 50)
    ctx.fill()

    ctx.beginPath()
    ctx.arc(32, 56, 5, 0, Math.PI * 2)
    ctx.fill()

    ctx.beginPath()
    ctx.arc(32, 12, 4, 0, Math.PI * 2)
    ctx.fill()
  }

  private drawCheck(ctx: CanvasRenderingContext2D): void {
    ctx.lineWidth = 8
    ctx.beginPath()
    ctx.moveTo(15, 34)
    ctx.lineTo(28, 48)
    ctx.lineTo(50, 18)
    ctx.stroke()
  }

  private drawPlay(ctx: CanvasRenderingContext2D): void {
    ctx.beginPath()
    ctx.moveTo(22, 16)
    ctx.lineTo(22, 48)
    ctx.lineTo(48, 32)
    ctx.closePath()
    ctx.fill()
  }

  private drawReboot(ctx: CanvasRenderingContext2D): void {
    ctx.lineWidth = 5
    ctx.beginPath()
    ctx.arc(32, 34, 19, 0.35 * Math.PI, 1.85 * Math.PI, false)
    ctx.stroke()

    ctx.beginPath()
    ctx.moveTo(40, 10)
    ctx.lineTo(50, 13)
    ctx.lineTo(45, 23)
    ctx.stroke()
  }

  private drawLock(ctx: CanvasRenderingContext2D): void {
    ctx.lineWidth = 5
    ctx.beginPath()
    ctx.arc(32, 26, 12, Math.PI, 0, false)
    ctx.stroke()

    ctx.beginPath()
    ctx.moveTo(18, 30)
    ctx.lineTo(46, 30)
    ctx.quadraticCurveTo(50, 30, 50, 34)
    ctx.lineTo(50, 50)
    ctx.quadraticCurveTo(50, 54, 46, 54)
    ctx.lineTo(18, 54)
    ctx.quadraticCurveTo(14, 54, 14, 50)
    ctx.lineTo(14, 34)
    ctx.quadraticCurveTo(14, 30, 18, 30)
    ctx.closePath()
    ctx.fill()
  }

  private drawGear(ctx: CanvasRenderingContext2D): void {
    ctx.save()
    ctx.translate(32, 32)

    for (let i = 0; i < 8; i++) {
      ctx.rotate(Math.PI / 4)
      ctx.fillRect(17, -5, 12, 10)
    }

    ctx.beginPath()
    ctx.arc(0, 0, 19, 0, Math.PI * 2)
    ctx.fill()

    ctx.fillStyle = '#FFFFFF'
    ctx.beginPath()
    ctx.arc(0, 0, 7, 0, Math.PI * 2)
    ctx.fill()

    ctx.restore()
  }

  private drawWarning(ctx: CanvasRenderingContext2D): void {
    ctx.beginPath()
    ctx.moveTo(32, 10)
    ctx.lineTo(55, 52)
    ctx.lineTo(9, 52)
    ctx.closePath()
    ctx.fill()

    ctx.strokeStyle = '#FFFFFF'
    ctx.lineWidth = 5
    ctx.beginPath()
    ctx.moveTo(32, 24)
    ctx.lineTo(32, 38)
    ctx.stroke()

    ctx.fillStyle = '#FFFFFF'
    ctx.beginPath()
    ctx.arc(32, 46, 3, 0, Math.PI * 2)
    ctx.fill()
  }

  private drawPerson(ctx: CanvasRenderingContext2D): void {
    ctx.beginPath()
    ctx.arc(32, 22, 10, 0, Math.PI * 2)
    ctx.fill()

    ctx.beginPath()
    ctx.moveTo(16, 54)
    ctx.quadraticCurveTo(18, 38, 32, 38)
    ctx.quadraticCurveTo(46, 38, 48, 54)
    ctx.closePath()
    ctx.fill()
  }

  private drawInfo(ctx: CanvasRenderingContext2D): void {
    ctx.beginPath()
    ctx.arc(32, 32, 24, 0, Math.PI * 2)
    ctx.fill()

    ctx.fillStyle = '#FFFFFF'
    ctx.beginPath()
    ctx.arc(32, 20, 3, 0, Math.PI * 2)
    ctx.fill()

    ctx.fillRect(29, 28, 6, 18)
  }
}