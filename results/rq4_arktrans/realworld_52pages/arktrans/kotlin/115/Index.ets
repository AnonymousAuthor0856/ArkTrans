@Entry
@Component
struct Index {
  @State settingsViewModel: number = 0
  @State localeDefault: string = 'en'
  @State onClickBack: number = 0
  @State viewModel: number = 0
  @State deleteString: string = 'Delete'
  @State deleteIcon: string = ''
  @State pinIcon: string = ''
  @State copyString: string = 'Copy'
  @State copyIcon: string = ''
  @State infoString: string = 'Information'
  @State infoIcon: string = ''
  @State coroutineScope: number = 0
  @State isExtremeAmoled: boolean = false

  build() {
    Stack() {
      // === BottomModal ===
      Column() {
        // === ModalBottomSheet ===
        Column() {
          // === SimpleDateFormat ===
          Text('2023-10-27')
            .fontSize(14)
            .fontColor('#888888')
            .margin({ top: 16, bottom: 8 })

          // === Column ===
          Column({ space: 0 }) {
            // === SettingsBox ===
            Row() {
              Image($r('app.media.startIcon'))
                .width(24)
                .height(24)
                .fillColor('#555555')
              Text('Created Time')
                .fontSize(16)
                .fontColor('#333333')
                .layoutWeight(1)
                .margin({ left: 12 })
              Text('2023-10-27 10:00')
                .fontSize(16)
                .fontColor('#666666')
            }
            .width('100%')
            .padding(16)
            .backgroundColor('#FFFFFF')
            .borderRadius({ topLeft: 16, topRight: 16 })

            // === SettingsBox ===
            Row() {
              Image($r('app.media.startIcon'))
                .width(24)
                .height(24)
                .fillColor('#555555')
              Text('Words')
                .fontSize(16)
                .fontColor('#333333')
                .layoutWeight(1)
                .margin({ left: 12 })
              Text('0')
                .fontSize(16)
                .fontColor('#666666')
            }
            .width('100%')
            .padding(16)
            .backgroundColor('#FFFFFF')
            .borderWidth({ bottom: 1 })
            .borderColor('#EEEEEE')

            // === SettingsBox ===
            Row() {
              Image($r('app.media.startIcon'))
                .width(24)
                .height(24)
                .fillColor('#555555')
              Text('Characters')
                .fontSize(16)
                .fontColor('#333333')
                .layoutWeight(1)
                .margin({ left: 12 })
              Text('0')
                .fontSize(16)
                .fontColor('#666666')
            }
            .width('100%')
            .padding(16)
            .backgroundColor('#FFFFFF')
            .borderRadius({ bottomLeft: 16, bottomRight: 16 })
          }
          .padding({ left: 20, right: 20, bottom: 20 })
        }
        .width('100%')
        .backgroundColor('#F8FBF1')
        .borderRadius({ topLeft: 24, topRight: 24 })
        .shadow({ radius: 10, color: '#1A000000', offsetY: -2 })
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.End)

      // === Note ===
      Column() {
        // Title Area
        Text('Sample Note Title')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#111111')
          .margin({ top: 60, left: 20, right: 20, bottom: 20 })

        // Description Area
        Text('Write your note description here...')
          .fontSize(18)
          .fontColor('#333333')
          .lineHeight(28)
          .margin({ left: 20, right: 20 })
          .layoutWeight(1)
      }
      .width('90%')
      .height('90%')
      .backgroundColor('#F2F0F7')
      .borderRadius(24)
      .margin({ top: 100 })
      .alignSelf(ItemAlign.Center)

      // === Column (Top Bar Container) ===
      Column({ space: 0 }) {
        // === MinimalisticMode ===
        Column() {
          // === Row (Main Top Bar) ===
          Row({ space: 0 }) {
            // === NavigationIcon ===
            Image($r('app.media.startIcon'))
              .width(24)
              .height(24)
              .fillColor('#333333')
              .margin({ left: 16, right: 8 })

            // === UndoButton ===
            Image($r('app.media.startIcon'))
              .width(24)
              .height(24)
              .fillColor('#333333')
              .margin({ right: 8 })

            // === TopBarActions ===
            Column() {
              // === Row (Undo/Save) ===
              Row({ space: 0 }) {
                // === RedoButton ===
                Image($r('app.media.startIcon'))
                  .width(24)
                  .height(24)
                  .fillColor('#333333')
                  .margin({ right: 8 })

                // === SaveButton ===
                Image($r('app.media.startIcon'))
                  .width(24)
                  .height(24)
                  .fillColor('#333333')
                  .margin({ right: 8 })
              }

              // === Row (More/Dropdown) ===
              Row({ space: 0 }) {
                // === MoreButton ===
                Image($r('app.media.startIcon'))
                  .width(24)
                  .height(24)
                  .fillColor('#333333')
                  .margin({ right: 8 })

                // === DropdownMenu ===
                Column() {
                  // === DropdownMenuItem (Delete) ===
                  Row() {
                    Image($r('app.media.startIcon'))
                      .width(20)
                      .height(20)
                      .fillColor('#FF5252')
                    Text(this.deleteString)
                      .fontSize(16)
                      .fontColor('#FF5252')
                      .margin({ left: 12 })
                  }
                  .width('100%')
                  .padding(12)

                  // === DropdownMenuItem (Pin) ===
                  Row() {
                    Image($r('app.media.startIcon'))
                      .width(20)
                      .height(20)
                      .fillColor('#333333')
                    Text('Pinned')
                      .fontSize(16)
                      .fontColor('#333333')
                      .margin({ left: 12 })
                  }
                  .width('100%')
                  .padding(12)

                  // === DropdownMenuItem (Copy) ===
                  Row() {
                    Image($r('app.media.startIcon'))
                      .width(20)
                      .height(20)
                      .fillColor('#333333')
                    Text(this.copyString)
                      .fontSize(16)
                      .fontColor('#333333')
                      .margin({ left: 12 })
                  }
                  .width('100%')
                  .padding(12)

                  // === DropdownMenuItem (Info) ===
                  Row() {
                    Image($r('app.media.startIcon'))
                      .width(20)
                      .height(20)
                      .fillColor('#333333')
                    Text(this.infoString)
                      .fontSize(16)
                      .fontColor('#333333')
                      .margin({ left: 12 })
                  }
                  .width('100%')
                  .padding(12)
                }
                .width(200)
                .backgroundColor('#FFFFFF')
                .borderRadius(8)
                .shadow({ radius: 4, color: '#1A000000' })
                .position({ x: -150, y: 40 })
              }
            }
            .layoutWeight(1)
            .alignItems(HorizontalAlign.End)

            // === ModeButton ===
            Column() {
              // === Row (RenderButtons) ===
              Row({ space: 0 }) {
                // === RenderButton 1 ===
                Image($r('app.media.startIcon'))
                  .width(24)
                  .height(24)
                  .fillColor('#333333')
                  .margin({ right: 4 })

                // === RenderButton 2 ===
                Image($r('app.media.startIcon'))
                  .width(24)
                  .height(24)
                  .fillColor('#333333')
                  .margin({ right: 4 })

                // === RenderButton 3 ===
                Image($r('app.media.startIcon'))
                  .width(24)
                  .height(24)
                  .fillColor('#333333')
              }
            }
            .margin({ right: 16 })
          }
          .width('100%')
          .padding({ top: 16, bottom: 16 })
          .backgroundColor('#F0F2F5')

          // === Column (Secondary Bar / Duplicate Structure from Skeleton) ===
          Column({ space: 0 }) {
            // === Row ===
            Row({ space: 0 }) {
              // === NavigationIcon ===
              Image($r('app.media.startIcon'))
                .width(24)
                .height(24)
                .fillColor('#333333')
                .margin({ left: 16, right: 8 })

              // === Spacer ===
              Blank().height(16).layoutWeight(1)

              // === ModeButton ===
              Column() {
                // === Row (RenderButtons) ===
                Row({ space: 0 }) {
                  // === RenderButton 1 ===
                  Image($r('app.media.startIcon'))
                    .width(24)
                    .height(24)
                    .fillColor('#333333')
                    .margin({ right: 4 })

                  // === RenderButton 2 ===
                  Image($r('app.media.startIcon'))
                    .width(24)
                    .height(24)
                    .fillColor('#333333')
                    .margin({ right: 4 })

                  // === RenderButton 3 ===
                  Image($r('app.media.startIcon'))
                    .width(24)
                    .height(24)
                    .fillColor('#333333')
                }
              }

              // === TopBarActions ===
              Column() {
                // === Row (Undo/Save) ===
                Row({ space: 0 }) {
                  // === RedoButton ===
                  Image($r('app.media.startIcon'))
                    .width(24)
                    .height(24)
                    .fillColor('#333333')
                    .margin({ right: 8 })

                  // === SaveButton ===
                  Image($r('app.media.startIcon'))
                    .width(24)
                    .height(24)
                    .fillColor('#333333')
                    .margin({ right: 8 })
                }

                // === Row (More/Dropdown) ===
                Row({ space: 0 }) {
                  // === MoreButton ===
                  Image($r('app.media.startIcon'))
                    .width(24)
                    .height(24)
                    .fillColor('#333333')
                    .margin({ right: 8 })

                  // === DropdownMenu ===
                  Column() {
                    // === DropdownMenuItem (Delete) ===
                    Row() {
                      Image($r('app.media.startIcon'))
                        .width(20)
                        .height(20)
                        .fillColor('#FF5252')
                      Text(this.deleteString)
                        .fontSize(16)
                        .fontColor('#FF5252')
                        .margin({ left: 12 })
                    }
                    .width('100%')
                    .padding(12)

                    // === DropdownMenuItem (Pin) ===
                    Row() {
                      Image($r('app.media.startIcon'))
                        .width(20)
                        .height(20)
                        .fillColor('#333333')
                      Text('Pinned')
                        .fontSize(16)
                        .fontColor('#333333')
                        .margin({ left: 12 })
                    }
                    .width('100%')
                    .padding(12)

                    // === DropdownMenuItem (Copy) ===
                    Row() {
                      Image($r('app.media.startIcon'))
                        .width(20)
                        .height(20)
                        .fillColor('#333333')
                      Text(this.copyString)
                        .fontSize(16)
                        .fontColor('#333333')
                        .margin({ left: 12 })
                    }
                    .width('100%')
                    .padding(12)

                    // === DropdownMenuItem (Info) ===
                    Row() {
                      Image($r('app.media.startIcon'))
                        .width(20)
                        .height(20)
                        .fillColor('#333333')
                      Text(this.infoString)
                        .fontSize(16)
                        .fontColor('#333333')
                        .margin({ left: 12 })
                    }
                    .width('100%')
                    .padding(12)
                  }
                  .width(200)
                  .backgroundColor('#FFFFFF')
                  .borderRadius(8)
                  .shadow({ radius: 4, color: '#1A000000' })
                  .position({ x: -150, y: 40 })
                }
              }
              .alignItems(HorizontalAlign.End)
              .margin({ right: 16 })
            }
            .width('100%')
            .alignItems(VerticalAlign.Center)
          }
        }
      }
      .padding(16)
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}