const AppColors = {
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

const AppSpacing = {
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
  private author: Author = { name: '', avatarColor: '' }
  private timestamp: string = ''

  build() {
    Row({ space: AppSpacing.sm }) {
      Column()
        .width(24)
        .height(24)
        .backgroundColor(this.author.avatarColor)
        .borderRadius(12)

      Text(this.author.name)
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.author.avatarColor)

      Text(this.timestamp)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.outline)
    }
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct PostCard {
  private post: Post = { author: { name: '', avatarColor: '' }, timestamp: '', title: '', body: '', votes: 0, commentCount: 0 }
  @Prop voteState: number
  onVote: (v: number) => void = () => {}

  build() {
    Row({ space: AppSpacing.md }) {
      Column({ space: AppSpacing.sm }) {
        Text('▲')
          .fontSize(20)
          .fontColor(this.voteState === 1 ? AppColors.secondary : AppColors.outline)
          .width(24)
          .height(24)
          .textAlign(TextAlign.Center)
          .onClick(() => {
            this.onVote(this.voteState === 1 ? 0 : 1)
          })
        Text(`${this.post.votes + this.voteState - 1}`)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.voteState !== 0 ? AppColors.secondary : AppColors.onSurface)
        Text('▼')
          .fontSize(20)
          .fontColor(this.voteState === -1 ? AppColors.primary : AppColors.outline)
          .width(24)
          .height(24)
          .textAlign(TextAlign.Center)
          .onClick(() => {
            this.onVote(this.voteState === -1 ? 0 : -1)
          })
      }
      .alignItems(HorizontalAlign.Center)

      Column({ space: AppSpacing.sm }) {
        AuthorInfo({ author: this.post.author, timestamp: this.post.timestamp })
        Text(this.post.title)
          .fontSize(22)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
        Text(this.post.body)
          .fontSize(16)
          .fontColor('#CCE0E0FF')
        Blank().height(AppSpacing.sm)
        Row({ space: AppSpacing.xl }) {
          Text(`${this.post.commentCount} Comments`)
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.outline)
          Text('Share')
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.outline)
        }
        .alignItems(VerticalAlign.Center)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface)
  }
}

@Component
struct ReplyCard {
  private reply: Reply = { id: 0, author: { name: '', avatarColor: '' }, timestamp: '', text: '', votes: 0 }

  build() {
    Row({ space: AppSpacing.md }) {
      Column()
        .width(2)
        .height('100%')
        .backgroundColor(this.reply.author.avatarColor)

      Column({ space: AppSpacing.xs }) {
        AuthorInfo({ author: this.reply.author, timestamp: this.reply.timestamp })
        Text(this.reply.text)
          .fontSize(16)
          .fontColor('#E6E0E0FF')
        Row({ space: AppSpacing.md }) {
          Text(`${this.reply.votes} votes`)
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.outline)
          Text('Reply')
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.outline)
        }
        .alignItems(VerticalAlign.Center)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
    }
    .width('100%')
    .alignItems(VerticalAlign.Top)
  }
}

@Entry
@Component
struct Index {
  @State voteState: number = 1
  private post: Post = {
    author: { name: 'user/compose_master', avatarColor: '#76FF03' },
    timestamp: '8 hours ago',
    title: 'The power of Jetpack Compose for single-file UIs',
    body: "Creating fully functional, beautiful UIs in a single Kotlin file is not just possible, it's becoming a new standard for prototypes and minimalist apps. What are your thoughts on this approach?",
    votes: 1337,
    commentCount: 42
  }
  private replies: Reply[] = [
    { id: 1, author: { name: 'dev/android_fan', avatarColor: '#FF00AA' }, timestamp: '7h ago', text: 'Absolutely agree! It simplifies dependency management and makes sharing snippets a breeze.', votes: 25 },
    { id: 2, author: { name: 'ux/designer_jane', avatarColor: '#00E5FF' }, timestamp: '5h ago', text: 'From a design perspective, having the design tokens and theme right next to the UI components is a game-changer for consistency.', votes: 18 },
    { id: 3, author: { name: 'newbie/coder', avatarColor: '#FFD600' }, timestamp: '2h ago', text: 'I found it a bit overwhelming at first. Any tips for organizing the file?', votes: 3 }
  ]

  build() {
    Column() {
      Row() {
        Text('←')
          .fontSize(20)
          .fontColor(AppColors.primary)
          .width(40)
          .height(40)
          .textAlign(TextAlign.Center)
          .onClick(() => {})
        Text('r/jetpackcompose')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
        Blank().width(40)
      }
      .width('100%')
      .padding({ left: AppSpacing.sm, right: AppSpacing.sm, top: 12, bottom: 12 })
      .backgroundColor(AppColors.surface)
      .alignItems(VerticalAlign.Center)

      List({ space: AppSpacing.sm }) {
        ListItem() {
          PostCard({
            post: this.post,
            voteState: this.voteState,
            onVote: (v: number) => {
              this.voteState = v
            }
          })
        }
        ListItem() {
          Text('TOP COMMENTS')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.outline)
            .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.sm, bottom: AppSpacing.sm })
        }
        ForEach(this.replies, (reply: Reply) => {
          ListItem() {
            ReplyCard({ reply: reply })
          }
        }, (reply: Reply) => reply.id.toString())
        ListItem() {
          Blank().height(AppSpacing.xxl)
        }
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ top: AppSpacing.lg, bottom: AppSpacing.lg })
      .scrollBar(BarState.Off)

      Row({ space: AppSpacing.md }) {
        Text('Add a comment...')
          .fontSize(16)
          .fontColor(AppColors.outline)
          .layoutWeight(1)
          .height(48)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(16)
          .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
          .textAlign(TextAlign.Start)

        Button('POST')
          .type(ButtonType.Normal)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onPrimary)
          .backgroundColor(AppColors.primary)
          .borderRadius(16)
          .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
      }
      .width('100%')
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.md })
      .backgroundColor(AppColors.surface)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}