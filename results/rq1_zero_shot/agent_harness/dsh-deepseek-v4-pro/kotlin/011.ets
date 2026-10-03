const Colors = {
  primary: '#00E5FF',
  secondary: '#FF00AA',
  tertiary: '#76FF03',
  background: '#101024',
  surface: '#1C1C3A',
  surfaceVariant: '#282850',
  outline: '#44446A',
  success: '#00C853',
  warning: '#FFD600',
  error: '#FF1744',
  onPrimary: '#000000',
  onSecondary: '#000000',
  onTertiary: '#000000',
  onBackground: '#E0E0FF',
  onSurface: '#E0E0FF'
}

const Spacing = {
  xs: 4,
  sm: 8,
  md: 12,
  lg: 16,
  xl: 24,
  xxl: 32
}

interface Author {
  name: string
  avatarColor: string
}

interface Reply {
  id: number
  author: Author
  timestamp: string
  text: string
  votes: number
}

interface Post {
  author: Author
  timestamp: string
  title: string
  body: string
  votes: number
  commentCount: number
}

@Component
struct AuthorInfo {
  @Prop name: string = ''
  @Prop avatarColor: string = ''
  @Prop timestamp: string = ''

  build() {
    Row({ space: Spacing.sm }) {
      Stack() {
        Circle().width(16).height(16).fill('#000000').opacity(0.2)
      }
      .width(24)
      .height(24)
      .borderRadius(12)
      .backgroundColor(this.avatarColor)

      Text(this.name)
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.avatarColor)

      Text(this.timestamp)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(Colors.outline)
    }
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct InfoChip {
  @Prop text: string = ''

  build() {
    Text(this.text)
      .fontSize(14)
      .fontWeight(FontWeight.Bold)
      .fontColor(Colors.outline)
      .letterSpacing(0.5)
  }
}

@Component
struct PostCard {
  @Prop authorName: string = ''
  @Prop avatarColor: string = ''
  @Prop timestamp: string = ''
  @Prop title: string = ''
  @Prop body: string = ''
  @Prop votes: number = 0
  @Prop commentCount: number = 0
  @Prop voteState: number = 1
  onVote: (v: number) => void = () => {}

  build() {
    Row({ space: Spacing.md }) {
      Column({ space: Spacing.sm }) {
        Text('▲')
          .fontSize(18)
          .fontColor(this.voteState == 1 ? Colors.secondary : Colors.outline)
          .onClick(() => { this.onVote(this.voteState == 1 ? 0 : 1) })

        Text((this.votes + this.voteState - 1).toString())
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.voteState != 0 ? Colors.secondary : Colors.onSurface)

        Text('▼')
          .fontSize(18)
          .fontColor(this.voteState == -1 ? Colors.primary : Colors.outline)
          .onClick(() => { this.onVote(this.voteState == -1 ? 0 : -1) })
      }
      .alignItems(HorizontalAlign.Center)

      Column({ space: Spacing.sm }) {
        AuthorInfo({ name: this.authorName, avatarColor: this.avatarColor, timestamp: this.timestamp })

        Text(this.title)
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onSurface)

        Text(this.body)
          .fontSize(16)
          .lineHeight(24)
          .fontColor(Colors.onSurface)
          .opacity(0.8)

        Blank().height(Spacing.sm)

        Row({ space: Spacing.xl }) {
          InfoChip({ text: this.commentCount + ' Comments' })
          InfoChip({ text: 'Share' })
        }
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .padding(Spacing.lg)
    .backgroundColor(Colors.surface)
    .alignItems(VerticalAlign.Top)
  }
}

@Component
struct ReplyCard {
  @Prop name: string = ''
  @Prop avatarColor: string = ''
  @Prop timestamp: string = ''
  @Prop text: string = ''
  @Prop votes: number = 0

  build() {
    Row({ space: Spacing.md }) {
      Blank()
        .width(2)
        .height('100%')
        .backgroundColor(this.avatarColor)
        .opacity(0.5)
        .borderRadius(2)

      Column({ space: Spacing.xs }) {
        AuthorInfo({ name: this.name, avatarColor: this.avatarColor, timestamp: this.timestamp })

        Text(this.text)
          .fontSize(16)
          .lineHeight(24)
          .fontColor(Colors.onSurface)
          .opacity(0.9)

        Row({ space: Spacing.md }) {
          InfoChip({ text: this.votes + ' votes' })
          InfoChip({ text: 'Reply' })
        }
        .alignItems(VerticalAlign.Center)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .padding({ left: Spacing.lg, right: Spacing.lg, top: Spacing.sm, bottom: Spacing.sm })
    .alignItems(VerticalAlign.Top)
  }
}

@Entry
@Component
struct Index {
  @State post: Post = {
    author: { name: 'user/compose_master', avatarColor: Colors.tertiary },
    timestamp: '8 hours ago',
    title: 'The power of Jetpack Compose for single-file UIs',
    body: "Creating fully functional, beautiful UIs in a single Kotlin file is not just possible, it's becoming a new standard for prototypes and minimalist apps. What are your thoughts on this approach?",
    votes: 1337,
    commentCount: 42
  }
  @State replies: Reply[] = [
    { id: 1, author: { name: 'dev/android_fan', avatarColor: Colors.secondary }, timestamp: '7h ago', text: 'Absolutely agree! It simplifies dependency management and makes sharing snippets a breeze.', votes: 25 },
    { id: 2, author: { name: 'ux/designer_jane', avatarColor: Colors.primary }, timestamp: '5h ago', text: 'From a design perspective, having the design tokens and theme right next to the UI components is a game-changer for consistency.', votes: 18 },
    { id: 3, author: { name: 'newbie/coder', avatarColor: Colors.warning }, timestamp: '2h ago', text: 'I found it a bit overwhelming at first. Any tips for organizing the file?', votes: 3 }
  ]
  @State voteState: number = 1

  build() {
    Column() {
      Row() {
        Text('←')
          .fontSize(20)
          .fontColor(Colors.primary)
          .onClick(() => {})

        Text('r/jetpackcompose')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Blank().width(20)
      }
      .width('100%')
      .height(56)
      .padding({ left: Spacing.lg, right: Spacing.lg })
      .backgroundColor(Colors.surface)
      .alignItems(VerticalAlign.Center)

      Scroll() {
        Column() {
          PostCard({
            authorName: this.post.author.name,
            avatarColor: this.post.author.avatarColor,
            timestamp: this.post.timestamp,
            title: this.post.title,
            body: this.post.body,
            votes: this.post.votes,
            commentCount: this.post.commentCount,
            voteState: this.voteState,
            onVote: (v: number) => { this.voteState = v }
          })

          Text('TOP COMMENTS')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.outline)
            .letterSpacing(0.5)
            .width('100%')
            .padding({ left: Spacing.lg, right: Spacing.lg, top: Spacing.sm, bottom: Spacing.sm })

          ForEach(this.replies, (reply: Reply) => {
            ReplyCard({
              name: reply.author.name,
              avatarColor: reply.author.avatarColor,
              timestamp: reply.timestamp,
              text: reply.text,
              votes: reply.votes
            })
          }, (reply: Reply) => reply.id.toString())
        }
        .width('100%')
      }
      .layoutWeight(1)
      .width('100%')

      Row({ space: Spacing.md }) {
        Stack({ alignContent: Alignment.Start }) {
          Text('Add a comment...')
            .fontSize(16)
            .fontColor(Colors.outline)
        }
        .layoutWeight(1)
        .height(48)
        .borderRadius(16)
        .backgroundColor(Colors.surfaceVariant)
        .padding({ left: Spacing.lg, right: Spacing.lg })

        Button('POST', { type: ButtonType.Normal })
          .backgroundColor(Colors.primary)
          .fontColor(Colors.onPrimary)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .borderRadius(16)
          .height(48)
          .padding({ left: Spacing.lg, right: Spacing.lg })
          .onClick(() => {})
      }
      .width('100%')
      .padding({ left: Spacing.lg, right: Spacing.lg, top: Spacing.md, bottom: Spacing.md })
      .backgroundColor(Colors.surface)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}
