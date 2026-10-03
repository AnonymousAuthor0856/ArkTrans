@Entry
@Component
struct Index {
  @State isLocked: boolean = true

  get statusColor() {
    return this.isLocked ? Color.Red : Color.Green
  }

  build() {
    Stack() {
      // === ZStack (Background) ===
      Stack() {
        // SecureColors background simulation
        Column()
          .width('100%')
          .height('100%')
          .backgroundColor('#F5F5F7') // Simulating SecureColors surface/background
          .ignoresSafeArea([SafeAreaType.SYSTEM])

        // === ScrollView ===
        Scroll() {
          // === VStack (Main Content) ===
          Column({ space: 0 }) {
            .padding({ left: 24, right: 24 })

            // === HStack (Header) ===
            Row() {
              // === VStack (Texts) ===
              Column({ space: 2 }) {
                Text('Welcome back,')
                  .fontColor('#808080') // SecureColors.textGray
                  .fontSize(14)
                Text('David Miller')
                  .fontColor(Color.Black)
                  .fontSize(24)
                  .fontWeight(FontWeight.Bold) // .black weight
              }

              Blank()

              // === ZStack (Avatar) ===
              Stack() {
                Circle()
                  .fill('#F5F5F5') // Color(red: 0.96...)
                  .width(48)
                  .height(48)
                  .overlay(
                    () => {
                      Circle()
                        .stroke('#E0E0E0') // Color(red: 0.88...)
                        .strokeWidth(1)
                    }
                  )

                Image($r('app.media.startIcon')) // Using required resource
                  .objectFit(ImageFit.Contain)
                  .width(20)
                  .height(20)
              }
            }

            Blank().height(40)

            // === VStack (Security Status Card) ===
            Column() {
              .width('100%')
              .padding(24)
              .backgroundColor('#FFFFFF') // SecureColors.surface
              .borderRadius(24)
              .overlay(
                () => {
                  Rect()
                    .borderRadius(24)
                    .border({ width: 1, color: '#E0E0E0' }) // SecureColors.border
                }
              )

              // === Button (Toggle Lock) ===
              Button() {
                // === ZStack (Button Content) ===
                Stack() {
                  Circle()
                    .fill(Color.White)
                    .width(80)
                    .height(80)
                    .overlay(
                      () => {
                        Circle()
                          .stroke(this.statusColor)
                          .opacity(0.1)
                          .strokeWidth(2)
                      }
                    )

                  Image($r('app.media.startIcon')) // Placeholder for lock/checkmark
                    .objectFit(ImageFit.Contain)
                    .width(36)
                    .height(36)
                }
              }
              .type(ButtonType.Normal)
              .backgroundColor(Color.Transparent)
              .onClick(() => {
                this.isLocked = !this.isLocked
              })
              .margin({ bottom: 16 })

              // === Text (Status Title) ===
              Text(this.isLocked ? 'SECURE' : 'UNLOCKED')
                .fontColor(this.statusColor)
                .fontSize(22)
                .fontWeight(FontWeight.Bold)
                .letterSpacing(2)

              Blank().height(8)

              // === Text (Status Description) ===
              Text(this.isLocked ? 'All perimeter doors are locked.' : 'Perimeter access is currently open.')
                .fontColor('#808080') // SecureColors.textGray
                .fontSize(14)
            }

            Blank().height(32)

            // === Text (Section Header) ===
            Text('My Access Points')
              .fontColor('#333333') // Color(white: 0.2) approximated for light mode visibility or kept dark if intended
              .fontSize(16)
              .fontWeight(FontWeight.Bold)

            Blank().height(16)

            // === VStack (Access Points List) ===
            Column({ space: 12 }) {
              // ForEach Simulation with static items as per "Implement every child" rule without external data source
              // Item 1
              Row() {
                Row({ space: 16 }) {
                  Stack() {
                    Rect()
                      .fill('#FAFAFA') // Color(red: 0.98...)
                      .width(40)
                      .height(40)
                      .borderRadius(10)

                    Image($r('app.media.startIcon'))
                      .objectFit(ImageFit.Contain)
                      .width(20)
                      .height(20)
                  }

                  Column({ space: 2 }) {
                    Text('Front Door')
                      .fontColor(Color.Black)
                      .fontSize(16)
                      .fontWeight(FontWeight.Medium)
                    Text('Last accessed: 2 mins ago')
                      .fontColor('#CCCCCC') // Color(white: 0.8) approximated
                      .fontSize(11)
                  }
                }

                Blank()

                Toggle({ type: ToggleType.Switch })
                  .width(50)
              }
              .width('100%')
              .padding(16)
              .backgroundColor(Color.White)
              .borderRadius(16)
              .overlay(
                () => {
                  Rect()
                    .borderRadius(16)
                    .border({ width: 1, color: '#EDEDED' }) // Color(red: 0.93...)
                }
              )

              // Item 2
              Row() {
                Row({ space: 16 }) {
                  Stack() {
                    Rect()
                      .fill('#FAFAFA')
                      .width(40)
                      .height(40)
                      .borderRadius(10)

                    Image($r('app.media.startIcon'))
                      .objectFit(ImageFit.Contain)
                      .width(20)
                      .height(20)
                  }

                  Column({ space: 2 }) {
                    Text('Back Gate')
                      .fontColor(Color.Black)
                      .fontSize(16)
                      .fontWeight(FontWeight.Medium)
                    Text('Last accessed: 1 hour ago')
                      .fontColor('#CCCCCC')
                      .fontSize(11)
                  }
                }

                Blank()

                Toggle({ type: ToggleType.Switch })
                  .width(50)
              }
              .width('100%')
              .padding(16)
              .backgroundColor(Color.White)
              .borderRadius(16)
              .overlay(
                () => {
                  Rect()
                    .borderRadius(16)
                    .border({ width: 1, color: '#EDEDED' })
                }
              )
            }

            Blank().height(32)

            // === Text (Recent Activity Header) ===
            Text('Recent Activity')
              .fontColor('#333333')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)

            Blank().height(16)

            // === VStack (Activity List) ===
            Column({ space: 0 }) {
              // Activity Item 1
              Row() {
                Text('10:23 AM')
                  .fontColor('#808080')
                  .fontSize(12)
                  .width(70)
                  .textAlign(TextAlign.Start)

                Rect()
                  .fill('#EDEDED') // Color(red: 0.93...)
                  .width(1)
                  .height(20)
                  .margin({ right: 16 })

                Column({ space: 2 }) {
                  Text('Door Locked')
                    .fontColor(Color.Black)
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                  Text('by David Miller')
                    .fontColor('#808080')
                    .fontSize(11)
                }

                Blank()
              }
              .padding({ top: 12, bottom: 12 })

              // Activity Item 2
              Row() {
                Text('09:15 AM')
                  .fontColor('#808080')
                  .fontSize(12)
                  .width(70)
                  .textAlign(TextAlign.Start)

                Rect()
                  .fill('#EDEDED')
                  .width(1)
                  .height(20)
                  .margin({ right: 16 })

                Column({ space: 2 }) {
                  Text('Gate Unlocked')
                    .fontColor(Color.Black)
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                  Text('by Sarah Jones')
                    .fontColor('#808080')
                    .fontSize(11)
                }

                Blank()
              }
              .padding({ top: 12, bottom: 12 })

              // Activity Item 3
              Row() {
                Text('Yesterday')
                  .fontColor('#808080')
                  .fontSize(12)
                  .width(70)
                  .textAlign(TextAlign.Start)

                Rect()
                  .fill('#EDEDED')
                  .width(1)
                  .height(20)
                  .margin({ right: 16 })

                Column({ space: 2 }) {
                  Text('System Check')
                    .fontColor(Color.Black)
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                  Text('by System')
                    .fontColor('#808080')
                    .fontSize(11)
                }

                Blank()
              }
              .padding({ top: 12, bottom: 12 })
            }

            Blank().height(24)
          }
        }
      }
    }
    .width('100%')
    .height('100%')
  }
}