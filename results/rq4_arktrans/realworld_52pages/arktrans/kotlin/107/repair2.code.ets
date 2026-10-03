@Entry
@Component
struct Index {
  @State showClearDialog: boolean = false

  build() {
    Column() {
      Stack({ alignContent: Alignment.Top }) {
        // === Scaffold Background ===
        Column() {
          .width('100%')
          .height('100%')
          .backgroundColor('#F8FBF1')
        }

        // === TopAppBar ===
        Row() {
          Button() {
            Image($r('app.media.startIcon'))
              .width(24)
              .height(24)
              .fillColor('#191D19')
          }
            .width(48)
            .height(48)
            .backgroundColor(Color.Transparent)

          Text('Settings')
            .fontSize(24)
            .fontWeight(FontWeight.Medium)
            .fontColor('#191D19')
        }
          .width('100%')
          .height(56)
          .padding({ left: 16, right: 16 })
          .alignItems(VerticalAlign.Center)

        // === LazyColumn (List) ===
        List({ space: 12 }) {
          ListItem() {
            // === SettingsGroupCard: Appearance ===
            Column() {
              // Group Header
              Row() {
                Image($r('app.media.startIcon'))
                  .width(20)
                  .height(20)
                  .fillColor('#1E6D3B')

                Blank().width(8)

                Text('Appearance')
                  .fontSize(16)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#1E6D3B')
              }
                .width('100%')
                .padding({ left: 24, right: 24, top: 8, bottom: 8 })
                .alignItems(VerticalAlign.Center)

              // Card Container
              Column() {
                .width('100%')
                .backgroundColor('#FFFFFF')
                .borderRadius(12)
                .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })

                // Item 1: Theme
                Column() {
                  Row() {
                    Column() {
                      Text('Theme')
                        .fontSize(16)
                        .fontColor('#191D19')
                      Text('Light, dark, or system default')
                        .fontSize(12)
                        .fontColor('#424940')
                    }.layoutWeight(1)

                    Text('System')
                      .fontSize(14)
                      .fontColor('#1E6D3B')

                    Image($r('app.media.startIcon'))
                      .width(18)
                      .height(18)
                      .fillColor('#424940')
                      .rotate({ angle: 90 })
                  }
                    .width('100%')
                    .padding(16)
                    .alignItems(VerticalAlign.Center)

                  Divider()
                    .color('#C1C9BE')
                    .margin({ left: 16, right: 16 })
                }

                // Item 2: Dynamic colors
                Column() {
                  Row() {
                    Column() {
                      Text('Dynamic colors')
                        .fontSize(16)
                        .fontColor('#191D19')
                      Text('Use Material You colors')
                        .fontSize(12)
                        .fontColor('#424940')
                    }.layoutWeight(1)

                    // Toggle Switch (Off)
                    Row() {
                      Circle()
                        .width(20)
                        .height(20)
                        .fill('#757575')
                    }
                      .width(48)
                      .height(28)
                      .borderRadius(14)
                      .backgroundColor('#E0E0E0')
                      .justifyContent(FlexAlign.Start)
                      .padding(4)
                  }
                    .width('100%')
                    .padding(16)
                    .alignItems(VerticalAlign.Center)

                  Divider()
                    .color('#C1C9BE')
                    .margin({ left: 16, right: 16 })
                }

                // Item 3: Strikethrough checked
                Column() {
                  Row() {
                    Column() {
                      Text('Strikethrough checked')
                        .fontSize(16)
                        .fontColor('#191D19')
                      Text('Strikethrough text on checked items')
                        .fontSize(12)
                        .fontColor('#424940')
                    }.layoutWeight(1)

                    // Toggle Switch (On)
                    Row() {
                      Circle()
                        .width(20)
                        .height(20)
                        .fill('#1E6D3B')
                    }
                      .width(48)
                      .height(28)
                      .borderRadius(14)
                      .backgroundColor('#D1F2DB')
                      .justifyContent(FlexAlign.End)
                      .padding(4)
                  }
                    .width('100%')
                    .padding(16)
                    .alignItems(VerticalAlign.Center)

                  Divider()
                    .color('#C1C9BE')
                    .margin({ left: 16, right: 16 })
                }

                // Item 4: Text size
                Column() {
                  Column() {
                    Text('Text size')
                      .fontSize(16)
                      .fontColor('#191D19')
                    Text('Note content text size: 15sp')
                      .fontSize(12)
                      .fontColor('#424940')
                  }.width('100%').padding({ left: 16, top: 16, right: 16 })

                  // Slider Visual Representation
                  Column() {
                    Row() {
                      // Track Left (Active)
                      Row() {
                        Circle().width(6).height(6).fill('#FFFFFF')
                        Blank().layoutWeight(1)
                        Circle().width(6).height(6).fill('#FFFFFF')
                        Blank().layoutWeight(1)
                        Circle().width(6).height(6).fill('#FFFFFF')
                        Blank().layoutWeight(1)
                        Circle().width(6).height(6).fill('#FFFFFF')
                        Blank().layoutWeight(1)
                        Circle().width(6).height(6).fill('#FFFFFF')
                      }
                        .height(24)
                        .borderRadius(12)
                        .backgroundColor('#1E6D3B')
                        .padding(4)
                        .layoutWeight(1)

                      // Thumb
                      Rect()
                        .width(4)
                        .height(40)
                        .fill('#1E6D3B')
                        .borderRadius(2)

                      // Track Right (Inactive)
                      Row() {
                        Circle().width(6).height(6).fill('#1E6D3B')
                        Blank().layoutWeight(1)
                        Circle().width(6).height(6).fill('#1E6D3B')
                        Blank().layoutWeight(1)
                        Circle().width(6).height(6).fill('#1E6D3B')
                        Blank().layoutWeight(1)
                        Circle().width(6).height(6).fill('#1E6D3B')
                        Blank().layoutWeight(1)
                        Circle().width(6).height(6).fill('#1E6D3B')
                      }
                        .height(24)
                        .borderRadius(12)
                        .backgroundColor('#D1F2DB')
                        .padding(4)
                        .layoutWeight(1)
                    }
                      .width('100%')
                      .padding({ left: 16, right: 16, bottom: 16 })
                      .alignItems(VerticalAlign.Center)
                  }

                  Divider()
                    .color('#C1C9BE')
                    .margin({ left: 16, right: 16 })
                }

                // Item 5: Preview labels
                Column() {
                  Column() {
                    Text('Preview labels')
                      .fontSize(16)
                      .fontColor('#191D19')
                    Text('Max labels shown in note card: 2')
                      .fontSize(12)
                      .fontColor('#424940')
                  }.width('100%').padding({ left: 16, top: 16, right: 16 })

                  // Slider Visual Representation
                  Column() {
                    Row() {
                      // Track Left (Active)
                      Row() {
                        Circle().width(6).height(6).fill('#FFFFFF')
                        Blank().layoutWeight(1)
                        Circle().width(6).height(6).fill('#FFFFFF')
                      }
                        .height(24)
                        .borderRadius(12)
                        .backgroundColor('#1E6D3B')
                        .padding(4)
                        .layoutWeight(1)

                      // Thumb
                      Rect()
                        .width(4)
                        .height(40)
                        .fill('#1E6D3B')
                        .borderRadius(2)

                      // Track Right (Inactive)
                      Row() {
                        Circle().width(6).height(6).fill('#1E6D3B')
                        Blank().layoutWeight(1)
                        Circle().width(6).height(6).fill('#1E6D3B')
                        Blank().layoutWeight(1)
                        Circle().width(6).height(6).fill('#1E6D3B')
                        Blank().layoutWeight(1)
                        Circle().width(6).height(6).fill('#1E6D3B')
                        Blank().layoutWeight(1)
                        Circle().width(6).height(6).fill('#1E6D3B')
                        Blank().layoutWeight(1)
                        Circle().width(6).height(6).fill('#1E6D3B')
                        Blank().layoutWeight(1)
                        Circle().width(6).height(6).fill('#1E6D3B')
                        Blank().layoutWeight(1)
                        Circle().width(6).height(6).fill('#1E6D3B')
                      }
                        .height(24)
                        .borderRadius(12)
                        .backgroundColor('#D1F2DB')
                        .padding(4)
                        .layoutWeight(1)
                    }
                      .width('100%')
                      .padding({ left: 16, right: 16, bottom: 16 })
                      .alignItems(VerticalAlign.Center)
                  }

                  Divider()
                    .color('#C1C9BE')
                    .margin({ left: 16, right: 16 })
                }

                // Item 6: Shown date
                Column() {
                  Row() {
                    Column() {
                      Text('Shown date')
                        .fontSize(16)
                        .fontColor('#191D19')
                      Text('Which date to show on note cards')
                        .fontSize(12)
                        .fontColor('#424940')
                    }.layoutWeight(1)

                    Text('Modified')
                      .fontSize(14)
                      .fontColor('#1E6D3B')

                    Image($r('app.media.startIcon'))
                      .width(18)
                      .height(18)
                      .fillColor('#424940')
                      .rotate({ angle: 90 })
                  }
                    .width('100%')
                    .padding(16)
                    .alignItems(VerticalAlign.Center)
                }

              }
            }
          }

          ListItem() {
            Blank().height(36)
          }
        }
          .width('100%')
          .layoutWeight(1)
          .padding({ left: 16, right: 16 })
      }
      .width('100%')
      .height('100%')

      // === AlertDialog Overlay ===
      if (this.showClearDialog) {
        Stack() {
          Column() {
            .width('100%')
            .height('100%')
            .backgroundColor('#80000000')
            .onClick(() => {
              this.showClearDialog = false
            })
          }

          Column() {
            .width('80%')
            .backgroundColor('#F8FBF1')
            .borderRadius(16)
            .padding(24)

            Text('Clear all data?')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor('#191D19')
              .margin({ bottom: 8 })

            Text('This will permanently delete all notes, labels, and reminders. This action cannot be undone.')
              .fontSize(14)
              .fontColor('#424940')
              .margin({ bottom: 24 })

            Row() {
              Button() {
                Text('Clear')
                  .fontColor('#BA1A1A')
              }
                .backgroundColor(Color.Transparent)
                .layoutWeight(1)
                .type(ButtonType.Capsule)

              Button() {
                Text('Cancel')
                  .fontColor('#1E6D3B')
              }
                .backgroundColor(Color.Transparent)
                .layoutWeight(1)
                .type(ButtonType.Capsule)
                .onClick(() => {
                  this.showClearDialog = false
                })
            }
          }
        }
      }
    }
  }
}