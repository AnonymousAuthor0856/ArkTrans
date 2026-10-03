@Entry
@Component
struct RootScreen {
  @State private orderId: string = '';
  @State private issue: string = '';
  @State private submitted: boolean = false;
  @State private orderIdIsFocused: boolean = false;
  @State private issueIsFocused: boolean = false;

  // AppTokens
  private primary: string = '#8E6BF2';
  private secondary: string = '#D3C1FF';
  private tertiary: string = '#B39DDB';
  private background: string = '#F5F3FF';
  private surface: string = '#FFFFFF';
  private surfaceVariant: string = '#ECE6F8';
  private outline: string = '#D1C4E9';
  private success: string = '#4CAF50';
  private warning: string = '#FFB300';
  private error: string = '#E53935';
  private onPrimary: string = '#FFFFFF';
  private onSecondary: string = '#2E1A47';
  private onBackground: string = '#2E1A47';
  private onSurface: string = '#2E1A47';

  private smallRadius: number = 8;
  private mediumRadius: number = 14;
  private largeRadius: number = 20;

  private spacingSm: number = 6;
  private spacingMd: number = 10;
  private spacingLg: number = 16;
  private spacingXl: number = 24;

  @Builder
  build() {
    Stack() {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(this.background)

      // Main content
      Column({ space: this.spacingLg }) {
        Text('After-Sale Service')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.onBackground)
          .width('100%')
          .textAlign(TextAlign.Start)

        // Card
        Column({ space: this.spacingMd }) {
          Text('Order ID')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.onSurface)

          // Order ID input
          Stack({ alignContent: Alignment.TopStart }) {
            if (this.orderId === '' && !this.orderIdIsFocused) {
              Text('Enter order number')
                .fontSize(14)
                .fontColor(this.onSurface + '80')
                .padding({ left: this.spacingMd, right: this.spacingMd, top: 19, bottom: 19 })
            }
            TextInput({ placeholder: '', text: this.orderId })
              .fontSize(14)
              .fontColor(this.onSurface)
              .height(56)
              .padding({ left: this.spacingMd, right: this.spacingMd })
              .backgroundColor(this.surfaceVariant)
              .borderRadius(this.mediumRadius)
              .border({
                width: 1,
                color: this.orderIdIsFocused ? this.primary : this.outline
              })
              .onFocus(() => {
                this.orderIdIsFocused = true;
              })
              .onBlur(() => {
                this.orderIdIsFocused = false;
              })
          }
          .width('100%')

          Text('Issue Description')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.onSurface)

          // Issue Description input
          Stack({ alignContent: Alignment.TopStart }) {
            if (this.issue === '' && !this.issueIsFocused) {
              Text('Describe your issue')
                .fontSize(14)
                .fontColor(this.onSurface + '80')
                .padding({ left: this.spacingMd, right: this.spacingMd, top: this.spacingSm + 4, bottom: this.spacingSm + 4 })
            }
            TextArea({ placeholder: '', text: this.issue })
              .fontSize(14)
              .fontColor(this.onSurface)
              .height(120)
              .padding({ left: this.spacingMd, right: this.spacingMd, top: this.spacingSm + 4, bottom: this.spacingSm + 4 })
              .backgroundColor(this.surfaceVariant)
              .borderRadius(this.mediumRadius)
              .border({
                width: 1,
                color: this.issueIsFocused ? this.primary : this.outline
              })
              .onFocus(() => {
                this.issueIsFocused = true;
              })
              .onBlur(() => {
                this.issueIsFocused = false;
              })
          }
          .width('100%')
        }
        .width('100%')
        .padding(this.spacingLg)
        .backgroundColor(this.surface)
        .borderRadius(this.largeRadius)
        .shadow({
          radius: 12,
          color: this.outline + '38',
          offsetX: 0,
          offsetY: 4
        })

        // Submit button
        Button('Submit Request')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.onPrimary)
          .width('100%')
          .height(56)
          .backgroundColor(this.primary)
          .borderRadius(this.largeRadius)
          .onClick(() => {
            this.submitted = true;
          })

        // Success message
        if (this.submitted) {
          Text('Request submitted successfully!')
            .fontSize(14)
            .fontColor(this.success)
            .width('100%')
            .padding(this.spacingLg)
            .backgroundColor(this.success + '26')
            .borderRadius(this.mediumRadius)
            .textAlign(TextAlign.Center)
        }

        Blank()
      }
      .width('100%')
      .height('100%')
      .padding(this.spacingLg)
    }
    .width('100%')
    .height('100%')
  }
}