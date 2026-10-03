@Entry
@Component
struct Index {
  @State currentStep: number = 1

  // Mock Data Interfaces
  interface StepItem {
    title: string
    description: string
  }

  interface SummaryItem {
    label: string
    value: string
  }

  interface DocItem {
    label: string
    status: string
  }

  // Mock Data
  private stepsData: StepItem[] = [
    { title: 'Profile', description: 'Tenant basics' },
    { title: 'Income', description: 'Proof details' },
    { title: 'References', description: 'Upload letters' },
    { title: 'Summary', description: 'Confirm submission' }
  ]

  private summaryItems: SummaryItem[] = [
    { label: 'Total Rent', value: '$2,400/mo' },
    { label: 'Security Deposit', value: '$2,400' }
  ]

  private checklist: DocItem[] = [
    { label: 'ID Verification', status: 'Verified' },
    { label: 'Credit Check', status: 'Pending' }
  ]

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column() {
        // === Header (Top App Bar) ===
        Row() {
          // Left Icon Placeholder
          Button() {
            Stack({ alignContent: Alignment.Center }) {
              Text('')
            }.width(30).height(30).borderRadius(15).backgroundColor('#F3E8FF')
          }

          // Center Title
          Column({ space: 0 }) {
            Text('LeaseWizard').fontSize(18).fontWeight(FontWeight.Medium).fontColor('#24132C')
            Text('Guided handoff').fontSize(14).fontColor('#6B7280')
          }.alignItems(HorizontalAlign.Center).layoutWeight(1)

          // Right Icon Placeholder
          Button() {
            Stack({ alignContent: Alignment.Center }) {
              Text('')
            }.width(30).height(30).borderRadius(15).backgroundColor('#D8B4FE')
          }
        }.width('100%').padding({ left: 20, right: 20, top: 10, bottom: 10 }).alignItems(VerticalAlign.Center)

        // === Scrollable Content ===
        Scroll() {
          Column({ space: 24 }) {
            
            // === Surface 1: Steps ===
            Column() {
              Column({ space: 16 }) {
                Text('Steps').fontSize(24).fontWeight(FontWeight.Bold).fontColor('#24132C')
                
                ForEach(this.stepsData, (step: StepItem, index: number) => {
                  Row({ space: 16 }) {
                    // Timeline Column
                    Column({ space: 0 }) {
                      // Circle Number
                      Stack({ alignContent: Alignment.Center }) {
                        Text(`${index + 1}`).fontSize(14).fontWeight(FontWeight.Medium)
                          .fontColor(index < this.currentStep ? '#FFFFFF' : '#24132C')
                      }
                      .width(28).height(28).borderRadius(14)
                      .backgroundColor(index < this.currentStep ? '#9333EA' : '#F3E8FF')

                      // Connector Line (only if not last item)
                      if (index < this.stepsData.length - 1) {
                        Column().width(4).height(32).backgroundColor('#F3E8FF')
                      }
                    }.alignItems(HorizontalAlign.Center)

                    // Text Info
                    Column({ space: 4 }).layoutWeight(1) {
                      Text(step.title).fontSize(18).fontWeight(FontWeight.Medium).fontColor('#24132C')
                      Text(step.description).fontSize(14).fontColor('#6B7280')
                    }

                    // Action Button
                    Button() {
                      Text(index < this.currentStep ? 'Edit' : 'Go')
                        .fontSize(14).fontWeight(FontWeight.Medium).fontColor('#24132C')
                    }
                    .backgroundColor('#F9A8D4')
                    .borderRadius(12)
                    .width(80).height(40)
                  }.alignItems(VerticalAlign.Center)
                }, (item: StepItem) => item.title)
              }.padding(20)
            }
            .backgroundColor('#FDF8FF')
            .borderRadius(24)
            .shadow({ radius: 10, color: '#1A000000', offsetY: 4 })

            // === Surface 2: Form ===
            Column() {
              Column({ space: 16 }) {
                Text('Form').fontSize(24).fontWeight(FontWeight.Bold).fontColor('#24132C')

                // Input: Full Name
                Column({ space: 8 }) {
                  TextInput({ placeholder: 'Full name' })
                    .type(InputType.Normal)
                    .text('Avery Tenant')
                    .backgroundColor('#FDF8FF')
                    .border({ width: 1, color: '#D8B4FE', radius: 12 })
                    .padding({ left: 16, top: 16, bottom: 16 })
                    .fontSize(18).fontColor('#24132C')
                }

                // Input: Contact
                Column({ space: 8 }) {
                  TextInput({ placeholder: 'Contact' })
                    .type(InputType.Email)
                    .text('avery@example.com')
                    .backgroundColor('#FDF8FF')
                    .border({ width: 1, color: '#D8B4FE', radius: 12 })
                    .padding({ left: 16, top: 16, bottom: 16 })
                    .fontSize(18).fontColor('#24132C')
                }

                 // Input: Income
                 Column({ space: 8 }) {
                  TextInput({ placeholder: 'Income' })
                    .type(InputType.Number)
                    .text('$85,000')
                    .backgroundColor('#FDF8FF')
                    .border({ width: 1, color: '#D8B4FE', radius: 12 })
                    .padding({ left: 16, top: 16, bottom: 16 })
                    .fontSize(18).fontColor('#24132C')
                }

                // Navigation Buttons
                Row({ space: 12 }) {
                  Button() {
                    Text('Back').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#24132C')
                  }
                  .backgroundColor('#F3E8FF').borderRadius(12).height(48).layoutWeight(1)

                  Button() {
                    Text('Next').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#FFFFFF')
                  }
                  .backgroundColor('#9333EA').borderRadius(12).height(48).layoutWeight(1)
                }
              }.padding(20)
            }
            .backgroundColor('#FDF8FF')
            .borderRadius(24)
            .shadow({ radius: 10, color: '#1A000000', offsetY: 4 })

            // === Surface 3: Summary ===
            Column() {
              Column({ space: 16 }) {
                Text('Summary').fontSize(24).fontWeight(FontWeight.Bold).fontColor('#24132C')

                // Summary List
                ForEach(this.summaryItems, (item: SummaryItem) => {
                  Row() {
                    Text(item.label).fontSize(16).fontWeight(FontWeight.Medium).fontColor('#24132C').layoutWeight(1)
                    Text(item.value).fontSize(14).fontColor('#6B7280')
                  }
                  .width('100%').padding(12).backgroundColor('#F3E8FF').borderRadius(12)
                }, (item: SummaryItem) => item.label)

                // Documents Section
                Column({ space: 8 }) {
                  Text('Documents').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#24132C')
                  
                  ForEach(this.checklist, (doc: DocItem) => {
                    Row() {
                      Text(doc.label).fontSize(14).fontColor('#24132C').layoutWeight(1)
                      Text(doc.status).fontSize(12).fontWeight(FontWeight.Medium).fontColor('#F472B6')
                    }
                    .width('100%').padding({ left: 12, right: 12, top: 8, bottom: 8 })
                    .backgroundColor('#F3E8FF').borderRadius(8)
                  }, (doc: DocItem) => doc.label)
                }
              }.padding(20)
            }
            .backgroundColor('#FDF8FF')
            .borderRadius(24)
            .shadow({ radius: 10, color: '#1A000000', offsetY: 4 })
          }
        }.layoutWeight(1)
      }
      .width('100%').height('100%').padding({ left: 20, right: 20, top: 16, bottom: 16 })
      .backgroundColor('#FDF8FF')
    }.width('100%').height('100%')
  }
}