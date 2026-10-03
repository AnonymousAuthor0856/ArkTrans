import { window } from '@kit.ArkUI';
import { UIContext } from '@kit.ArkUI';

@Entry
@Component
struct Index {
  @State text: string = ''
  private context: UIContext = this.getUIContext()

  aboutToAppear() {
    let windowClass: window.Window | null = null;
    try {
      windowClass = window.getWindowSync(this.context);
      if (windowClass) {
        windowClass.setWindowSystemBarProperties({
          statusBarContentColor: '#E2E8F0'
        });
      }
    } catch (e) {
      console.error('Failed to set window properties');
    }
  }

  build() {
    Stack() {
      // === ZStack ===
      Stack({ alignContent: Alignment.Bottom }) {
        // statusBarHidden(true) removed as it's not a valid UI component call in build

        // === VStack ===
        Column({ space: 0 }) {
          // === HStack ===
          Row() {
            // === Button ===
            Button()
            // === Spacer ===
            Blank()
            // === VStack ===
            Column() {
              // === Text ===
              Text('HoloChat Dock').fontColor('#E2E8F0').fontSize(16)
              // === Text ===
              Text('Dark neon bridge').fontColor('#E2E8F0').opacity(0.7).fontSize(12)
            }
            // === Spacer ===
            Blank()
            // === Button ===
            Button()
          }.backgroundColor('#1F2937').padding({ top: 4, bottom: 4 }).padding({ left: 12, right: 12 })

          // === ScrollView ===
          Scroll() {
            // === VStack ===
            Column() {
              // === ScrollView ===
              Scroll() {
                // === HStack ===
                Row() {
                  // === ForEach ===
                  ForEach([1, 2, 3], (item: number) => {
                    // === Button ===
                    Button() {
                      // === Text ===
                      Text('Filter')
                    }
                    .borderRadius(8)
                    .borderWidth(1)
                    .borderColor('#334155')
                    .backgroundColor('#1F2937')
                  })
                }.padding({ left: 12, right: 12 })
              }

              // === HStack ===
              Row() {
                // === SummaryBlock ===
                SummaryBlock({ props: { title: 'Live docks', value: '12', accent: '#22D3EE' } })
                // === SummaryBlock ===
                SummaryBlock({ props: { title: 'Escalations', value: '3', accent: '#A78BFA' } })
                // === SummaryBlock ===
                SummaryBlock({ props: { title: 'Queued', value: '5', accent: '#7C3AED' } })
              }

              // === ForEach ===
              ForEach([{ name: 'Thread 1', status: 'Active', isPriority: true, unread: 5, snippet: 'This is a snippet.' },
                       { name: 'Thread 2', status: 'Pending', isPriority: false, unread: 0, snippet: 'Another snippet.' }], (thread: ThreadItem) => {
                // === VStack ===
                Column() {
                  // === HStack ===
                  Row() {
                    // === VStack ===
                    Column() {
                      // === Text ===
                      Text(thread.name).fontColor('#E2E8F0').fontSize(18)
                      // === Text ===
                      Text(thread.status).fontColor(thread.isPriority ? '#22D3EE' : '#E2E8F0').opacity(thread.isPriority ? 1 : 0.7).fontSize(12)
                    }
                    // === Spacer ===
                    Blank()
                    // === Text ===
                    Text(thread.unread > 0 ? `+${thread.unread}` : '✓').borderRadius(8).backgroundColor('#334155').padding({ top: 2, bottom: 2 }).padding({ left: 4, right: 4 }).fontColor('#E2E8F0').fontSize(12)
                  }
                  // === Text ===
                  Text(thread.snippet).fontColor('#E2E8F0').opacity(0.9).fontSize(14)
                  // === HStack ===
                  Row() {
                    // === Text ===
                    Text(thread.isPriority ? 'Priority' : 'Standard').borderRadius(8).backgroundColor('#334155').padding({ top: 2, bottom: 2 }).padding({ left: 4, right: 4 }).fontColor('#E2E8F0').fontSize(12)
                    // === Button ===
                    Button()
                  }
                }.borderRadius(16).backgroundColor('#1F2937').padding(12)
              })

              // === VStack ===
              Column() {
                // === Text ===
                Text('Dock filters').fontColor('#E2E8F0').fontSize(16)
                // === HStack ===
                Row() {
                  // === Button ===
                  Button()
                  // === Button ===
                  Button()
                }
              }.borderRadius(16).backgroundColor('#334155').width('100%').alignItems(HorizontalAlign.Start).padding(12)

              // === Spacer ===
              Blank().height(100)
            }.padding({ top: 8, bottom: 8 })
          }
        }

        // === VStack ===
        Column() {
          // === Spacer ===
          Blank()
          // === HStack ===
          Row() {
            // === Spacer ===
            Blank()
            // === Button ===
            Button().padding({ bottom: 80 }).padding({ right: 12 })
          }
        }

        // === HStack ===
        Row() {
          // === ZStack ===
          Stack({ alignContent: Alignment.Start }) {
            // === Text ===
            Text('Message dock...').padding({ left: 8, right: 8 }).fontColor('#E2E8F0').opacity(0.6).fontSize(12)
            // === TextField ===
            TextInput({ placeholder: '', controller: new TextInputController() }).text(this.text).onChange((value: string) => { this.text = value }).padding({ top: 4, bottom: 4 }).padding({ left: 8, right: 8 }).fontColor('#E2E8F0').fontSize(14)
          }.borderRadius(12).backgroundColor('#1F2937').height(48)

          // === Button ===
          Button() {
            // === Text ===
            Text('Send').borderRadius(12).backgroundColor('#7C3AED').height(48).padding({ left: 20, right: 20 }).fontColor('#050714').fontSize(12)
          }
        }.shadow({ radius: 6, color: '#00000033', offsetY: -2 }).backgroundColor('#334155').padding({ top: 4, bottom: 4 }).padding({ left: 12, right: 12 })
      }
    }.width('100%').height('100%')
  }
}

interface ThreadItem {
  name: string;
  status: string;
  isPriority: boolean;
  unread: number;
  snippet: string;
}

interface SummaryBlockProps {
  title: string;
  value: string;
  accent: string;
}

@Component
struct SummaryBlock {
  private props: SummaryBlockProps = { title: '', value: '', accent: '' }

  build() {
    Column() {
      Text(this.props.value).fontColor(this.props.accent).fontSize(20).fontWeight(FontWeight.Bold)
      Text(this.props.title).fontColor('#E2E8F0').opacity(0.7).fontSize(12)
    }.alignItems(HorizontalAlign.Center)
  }
}