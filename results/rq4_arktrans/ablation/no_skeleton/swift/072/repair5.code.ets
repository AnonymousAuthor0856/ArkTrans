@Entry
@Component
struct ReliefFundApp {
  @State fullName: string = ''
  @State organization: string = ''
  @State contact: string = ''
  @State narrative: string = ''

  build() {
    // === Stack ===
    // props: {}
    // modifier: { width: '100%', height: '100%' }
    // children: 2
    Stack() {
      // === Column ===
      // props: { space: 0 }
      // modifier: { width: '100%', backgroundColor: '#FBF8F3' }
      // children: 2
      Column() {
        // === Row ===
        // props: {}
        // modifier: { width: '100%', padding: { left: 24, right: 24, top: 10, bottom: 20 }, alignItems: ItemAlign.Center }
        // children: 3
        Row() {
          // === Circle ===
          // modifier: { width: 48, height: 48, backgroundColor: '#EBE2D6' }
          Circle().width(48).height(48).backgroundColor('#EBE2D6')
          
          // === Blank ===
          Blank()
          
          // === Column ===
          // props: { space: 2 }
          // modifier: { alignItems: HorizontalAlign.Center }
          // children: 2
          Column({ space: 2 }) {
            // === Text ===
            // props: { text: 'ReliefFund' }
            // modifier: { fontSize: 19, fontWeight: FontWeight.Bold, color: '#3D352E' }
            Text('ReliefFund').fontSize(19).fontWeight(FontWeight.Bold).fontColor('#3D352E')
            
            // === Text ===
            // props: { text: 'Civic support intake' }
            // modifier: { fontSize: 13, fontWeight: FontWeight.Normal, color: '#8A8A8E' }
            Text('Civic support intake').fontSize(13).fontWeight(FontWeight.Normal).fontColor('#8A8A8E')
          }
          
          // === Blank ===
          Blank()
          
          // === Circle ===
          // modifier: { width: 48, height: 48, backgroundColor: '#EBE2D6' }
          Circle().width(48).height(48).backgroundColor('#EBE2D6')
        }

        // === Scroll ===
        // props: { scrollable: ScrollDirection.Vertical, barPosition: BarPosition.Outside }
        // modifier: { width: '100%', layoutWeight: 1 }
        // children: 1
        Scroll() {
          // === Column ===
          // props: { space: 24 }
          // modifier: { width: '100%', padding: { left: 16, right: 16, bottom: 40 } }
          // children: 2
          Column({ space: 24 }) {
            // === ApplicantDetailsCard ===
            this.ApplicantDetailsCard()
            
            // === SummaryCard ===
            this.SummaryCard()
          }
        }
      }
    }.width('100%').height('100%')
  }

  @Builder
  ApplicantDetailsCard() {
    // === Column ===
    // props: { space: 16 }
    // modifier: { width: '100%', padding: 24, backgroundColor: '#F7F3EE', borderRadius: 32, alignItems: HorizontalAlign.Start }
    // children: 6
    Column({ space: 16 }) {
      // === Text ===
      // props: { text: 'Applicant details' }
      // modifier: { fontSize: 22, fontWeight: FontWeight.Bold, color: '#3D352E', marginBottom: 4 }
      Text('Applicant details').fontSize(22).fontWeight(FontWeight.Bold).fontColor('#3D352E').margin({ bottom: 4 })

      // === CustomTextField (Full name) ===
      this.CustomTextField({ placeholder: 'Full name', value: this.fullName, onInput: (val: string) => this.fullName = val })
      
      // === CustomTextField (Organization) ===
      this.CustomTextField({ placeholder: 'Organization', value: this.organization, onInput: (val: string) => this.organization = val })
      
      // === CustomTextField (Contact) ===
      this.CustomTextField({ placeholder: 'Contact', value: this.contact, onInput: (val: string) => this.contact = val })
      
      // === CustomTextField (Narrative) ===
      Column() {
        this.CustomTextField({ placeholder: 'Relief narrative', value: this.narrative, onInput: (val: string) => this.narrative = val })
      }.margin({ bottom: 90 })

      // === Row (Buttons) ===
      // props: { space: 2 }
      // modifier: { width: '100%', marginTop: 80 }
      // children: 3
      Row({ space: 2 }) {
        // === Button (Back) ===
        // modifier: { flexShrink: 1, flexGrow: 1, backgroundColor: '#EBE2D6', borderRadius: 16, height: 96 }
        // children: 1
        Button() {
          // === Text ===
          // props: { text: 'Back' }
          // modifier: { fontSize: 14, fontWeight: FontWeight.Medium, color: '#000000' }
          Text('Back').fontSize(14).fontWeight(FontWeight.Medium).fontColor('#000000')
        }.flexShrink(1).flexGrow(1).backgroundColor('#EBE2D6').borderRadius(16).height(96)

        // === Button (Next) ===
        // modifier: { flexShrink: 1, flexGrow: 1, backgroundColor: '#B58B5A', borderRadius: 16, height: 96 }
        // children: 1
        Button() {
          // === Text ===
          // props: { text: 'Next' }
          // modifier: { fontSize: 14, fontWeight: FontWeight.Medium, color: '#000000' }
          Text('Next').fontSize(14).fontWeight(FontWeight.Medium).fontColor('#000000')
        }.flexShrink(1).flexGrow(1).backgroundColor('#B58B5A').borderRadius(16).height(96)
      }.margin({ top: 80 })
    }
  }

  @Builder
  SummaryCard() {
    // === Column ===
    // props: { space: 16 }
    // modifier: { width: '100%', padding: 24, backgroundColor: '#F7F3EE', borderRadius: 32, alignItems: HorizontalAlign.Start }
    // children: 2
    Column({ space: 16 }) {
      // === Text ===
      // props: { text: 'Summary' }
      // modifier: { fontSize: 22, fontWeight: FontWeight.Bold, color: '#3D352E' }
      Text('Summary').fontSize(22).fontWeight(FontWeight.Bold).fontColor('#3D352E')

      // === SummaryRow ===
      this.SummaryRow({ label: 'Requested', value: '$4,500' })
    }
  }

  @Builder
  CustomTextField(params: TextFieldParams) {
    // === TextInput ===
    // props: { placeholder: params.placeholder, text: params.value }
    // event: { onChange: params.onInput }
    // modifier: { width: '100%', height: 18, backgroundColor: '#FBF8F3', borderRadius: 16, padding: { left: 16, right: 16 }, borderColor: '#C5B8A9', borderWidth: 1.5, borderStyle: BorderStyle.Solid }
    TextInput({ placeholder: params.placeholder, text: params.value })
      .onChange((value: string) => {
        params.onInput(value)
      })
      .width('100%')
      .height(18)
      .backgroundColor('#FBF8F3')
      .borderRadius(16)
      .padding({ left: 16, right: 16 })
      .border({ width: 1.5, color: '#C5B8A9', style: BorderStyle.Solid })
  }

  @Builder
  SummaryRow(params: SummaryRowParams) {
    // === Row ===
    // props: {}
    // modifier: { width: '100%', padding: 20, backgroundColor: '#EBE2D6', borderRadius: 16, alignItems: ItemAlign.Center }
    // children: 3
    Row() {
      // === Text ===
      // props: { text: params.label }
      // modifier: { fontSize: 15, fontWeight: FontWeight.Medium, color: '#3D352E' }
      Text(params.label).fontSize(15).fontWeight(FontWeight.Medium).fontColor('#3D352E')
      
      // === Blank ===
      Blank()
      
      // === Text ===
      // props: { text: params.value }
      // modifier: { fontSize: 15, fontWeight: FontWeight.Medium, color: '#000000' }
      Text(params.value).fontSize(15).fontWeight(FontWeight.Medium).fontColor('#000000')
    }.width('100%').padding(20).backgroundColor('#EBE2D6').borderRadius(16).alignItems(HorizontalAlign.Center)
  }
}

interface TextFieldParams {
  placeholder: string;
  value: string;
  onInput: (val: string) => void;
}

interface SummaryRowParams {
  label: string;
  value: string;
}