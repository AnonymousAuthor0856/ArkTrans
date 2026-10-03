package com.example.singlefileui

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.BorderStroke
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.WindowInsets
import androidx.compose.foundation.layout.aspectRatio
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.AssistChip
import androidx.compose.material3.AssistChipDefaults
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.CenterAlignedTopAppBar
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.FilterChip
import androidx.compose.material3.FilterChipDefaults
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Shapes
import androidx.compose.material3.Surface
import androidx.compose.material3.Switch
import androidx.compose.material3.SwitchDefaults
import androidx.compose.material3.Text
import androidx.compose.material3.Typography
import androidx.compose.material3.lightColorScheme
import androidx.compose.runtime.Composable
import androidx.compose.runtime.mutableStateListOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsCompat
import androidx.core.view.WindowInsetsControllerCompat

private const val NAME = "007_FinanceWallect_en"
private const val UI_TYPE = "Finance Wallet"
private const val STYLE_THEME = "High-Contrast Accessible"
private const val LANG = "en"
private const val BASELINE_SIZE = "1280x720"

object AppTokens {
    object Colors {
        val primary = Color(0xFF1F2937)
        val secondary = Color(0xFF10B981)
        val tertiary = Color(0xFF3B82F6)
        val background = Color(0xFFF3F4F6)
        val surface = Color(0xFFFFFFFF)
        val surfaceVariant = Color(0xFFE5E7EB)
        val outline = Color(0xFFD1D5DB)
        val success = Color(0xFF16A34A)
        val warning = Color(0xFFF59E0B)
        val error = Color(0xFFEF4444)
        val onPrimary = Color(0xFFFFFFFF)
        val onSecondary = Color(0xFF0B1220)
        val onTertiary = Color(0xFFFFFFFF)
        val onBackground = Color(0xFF0B1220)
        val onSurface = Color(0xFF0B1220)
    }
    object TypographyTokens {
        val display = TextStyle(fontSize = 24.sp, fontWeight = FontWeight.SemiBold, lineHeight = 30.sp, letterSpacing = 0.sp)
        val headline = TextStyle(fontSize = 18.sp, fontWeight = FontWeight.SemiBold, lineHeight = 24.sp, letterSpacing = 0.sp)
        val title = TextStyle(fontSize = 14.sp, fontWeight = FontWeight.Medium, lineHeight = 18.sp, letterSpacing = 0.sp)
        val body = TextStyle(fontSize = 12.sp, fontWeight = FontWeight.Normal, lineHeight = 16.sp, letterSpacing = 0.sp)
        val label = TextStyle(fontSize = 10.sp, fontWeight = FontWeight.Medium, lineHeight = 14.sp, letterSpacing = 0.sp)
    }
    object Shapes {
        val small = RoundedCornerShape(6.dp)
        val medium = RoundedCornerShape(8.dp)
        val large = RoundedCornerShape(12.dp)
    }
    object Spacing {
        val xs = 2.dp
        val sm = 4.dp
        val md = 6.dp
        val lg = 8.dp
        val xl = 12.dp
        val xxl = 16.dp
        val xxxl = 24.dp
    }
    data class ShadowSpec(val elevation: Dp, val radius: Dp, val dy: Dp, val opacity: Float)
    object ElevationMapping {
        val level1 = ShadowSpec(1.dp, 2.dp, 0.5.dp, 0.12f)
        val level2 = ShadowSpec(2.dp, 4.dp, 1.dp, 0.14f)
        val level3 = ShadowSpec(3.dp, 6.dp, 1.5.dp, 0.16f)
        val level4 = ShadowSpec(4.dp, 8.dp, 2.dp, 0.18f)
        val level5 = ShadowSpec(5.dp, 10.dp, 2.5.dp, 0.2f)
    }
}

private val AppColorScheme = lightColorScheme(
    primary = AppTokens.Colors.primary,
    onPrimary = AppTokens.Colors.onPrimary,
    secondary = AppTokens.Colors.secondary,
    onSecondary = AppTokens.Colors.onSecondary,
    tertiary = AppTokens.Colors.tertiary,
    onTertiary = AppTokens.Colors.onTertiary,
    background = AppTokens.Colors.background,
    onBackground = AppTokens.Colors.onBackground,
    surface = AppTokens.Colors.surface,
    onSurface = AppTokens.Colors.onSurface,
    surfaceVariant = AppTokens.Colors.surfaceVariant,
    outline = AppTokens.Colors.outline,
    error = AppTokens.Colors.error
)

private val AppTypography = Typography(
    displayLarge = AppTokens.TypographyTokens.display,
    headlineMedium = AppTokens.TypographyTokens.headline,
    titleMedium = AppTokens.TypographyTokens.title,
    bodyMedium = AppTokens.TypographyTokens.body,
    labelMedium = AppTokens.TypographyTokens.label
)

@Composable
fun AppTheme(content: @Composable () -> Unit) {
    MaterialTheme(
        colorScheme = AppColorScheme,
        typography = AppTypography,
        shapes = Shapes(
            extraSmall = AppTokens.Shapes.small,
            small = AppTokens.Shapes.small,
            medium = AppTokens.Shapes.medium,
            large = AppTokens.Shapes.large,
            extraLarge = AppTokens.Shapes.large
        ),
        content = content
    )
}

data class AccountCard(val id: Int, val name: String, val balance: String, val accent: Color)
data class TxItem(val id: Int, val title: String, val subtitle: String, val amount: String, val positive: Boolean)

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun RootScreen() {
    val showBalance = remember { mutableStateOf(true) }
    val range = listOf("All", "Week", "Month", "Year")
    val selected = remember { mutableStateOf("Month") }
    val flags = remember { mutableStateListOf<String>() }
    val accounts = remember {
        listOf(
            AccountCard(1, "Wallet", "$2,845.20", Color(0xFF10B981)),
            AccountCard(2, "Savings", "$8,120.00", Color(0xFF3B82F6)),
            AccountCard(3, "Investments", "$15,430.55", Color(0xFFF59E0B))
        )
    }
    val txs = remember {
        listOf(
            TxItem(1, "Grocery Market", "Today • 12:40", "-$32.18", false),
            TxItem(2, "Salary", "Yesterday • 09:00", "+$3,200.00", true),
            TxItem(3, "Coffee Shop", "Yesterday • 15:22", "-$4.90", false),
            TxItem(4, "ETF Purchase", "Mon • 10:05", "-$250.00", false),
            TxItem(5, "Refund", "Sun • 18:40", "+$18.99", true)
        )
    }
    Scaffold(
        contentWindowInsets = WindowInsets(0),
        topBar = {
            CenterAlignedTopAppBar(
                title = {
                    Row(verticalAlignment = Alignment.CenterVertically, horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm)) {
                        Box(modifier = Modifier.size(20.dp).background(AppTokens.Colors.primary, AppTokens.Shapes.small))
                        Text(text = "Wallet", style = MaterialTheme.typography.displayLarge, color = MaterialTheme.colorScheme.onSurface)
                    }
                }
            )
        },
        bottomBar = {
            Surface(color = MaterialTheme.colorScheme.surface, tonalElevation = AppTokens.ElevationMapping.level3.elevation, shadowElevation = AppTokens.ElevationMapping.level3.elevation) {
                Row(modifier = Modifier.fillMaxWidth().padding(horizontal = AppTokens.Spacing.lg, vertical = AppTokens.Spacing.md), horizontalArrangement = Arrangement.SpaceBetween, verticalAlignment = Alignment.CenterVertically) {
                    Column(verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.xs), horizontalAlignment = Alignment.Start) {
                        Text(text = "Total Balance", style = MaterialTheme.typography.labelMedium, color = MaterialTheme.colorScheme.onSurface)
                        Text(text = if (showBalance.value) "$26,395.75" else "•••••••", style = MaterialTheme.typography.headlineMedium, color = MaterialTheme.colorScheme.onSurface)
                    }
                    Button(onClick = {}, colors = ButtonDefaults.buttonColors(containerColor = MaterialTheme.colorScheme.secondary, contentColor = MaterialTheme.colorScheme.onSecondary), shape = AppTokens.Shapes.large, modifier = Modifier.height(44.dp).width(140.dp)) {
                        Text(text = "Add Money", style = MaterialTheme.typography.titleMedium)
                    }
                }
            }
        },
        containerColor = MaterialTheme.colorScheme.background
    ) { padding ->
        LazyColumn(modifier = Modifier.fillMaxSize().padding(padding).padding(horizontal = AppTokens.Spacing.lg, vertical = AppTokens.Spacing.md), verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.lg), contentPadding = PaddingValues(bottom = AppTokens.Spacing.xxxl)) {
            item {
                Row(modifier = Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.SpaceBetween, verticalAlignment = Alignment.CenterVertically) {
                    Row(horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm), verticalAlignment = Alignment.CenterVertically) {
                        range.forEach { r ->
                            val active = r == selected.value
                            FilterChip(selected = active, onClick = { selected.value = r }, label = { Text(text = r, style = if (active) MaterialTheme.typography.titleMedium else MaterialTheme.typography.bodyMedium, color = if (active) MaterialTheme.colorScheme.onPrimary else MaterialTheme.colorScheme.onSurface) }, colors = FilterChipDefaults.filterChipColors(containerColor = if (active) MaterialTheme.colorScheme.primary else MaterialTheme.colorScheme.surface, selectedContainerColor = MaterialTheme.colorScheme.primary), shape = AppTokens.Shapes.medium, border = BorderStroke(1.dp, MaterialTheme.colorScheme.outline))
                        }
                    }
                    Row(horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm), verticalAlignment = Alignment.CenterVertically) {
                        Text(text = "Hide", style = MaterialTheme.typography.labelMedium, color = MaterialTheme.colorScheme.onSurface)
                        Switch(checked = !showBalance.value, onCheckedChange = { showBalance.value = !it }, colors = SwitchDefaults.colors(checkedThumbColor = MaterialTheme.colorScheme.onPrimary, checkedTrackColor = MaterialTheme.colorScheme.primary))
                    }
                }
            }
            items(accounts) { a ->
                Card(shape = AppTokens.Shapes.large, colors = CardDefaults.cardColors(containerColor = MaterialTheme.colorScheme.surface), elevation = CardDefaults.cardElevation(defaultElevation = AppTokens.ElevationMapping.level2.elevation), border = BorderStroke(1.dp, MaterialTheme.colorScheme.outline), modifier = Modifier.fillMaxWidth().heightIn(min = 120.dp)) {
                    Column(modifier = Modifier.fillMaxWidth().padding(AppTokens.Spacing.lg), verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm), horizontalAlignment = Alignment.Start) {
                        Row(modifier = Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.SpaceBetween, verticalAlignment = Alignment.CenterVertically) {
                            Row(verticalAlignment = Alignment.CenterVertically, horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm)) {
                                Box(modifier = Modifier.size(16.dp).background(a.accent, AppTokens.Shapes.small))
                                Text(text = a.name, style = MaterialTheme.typography.titleMedium, color = MaterialTheme.colorScheme.onSurface)
                            }
                            AssistChip(onClick = {}, label = { Text(text = "Manage", style = MaterialTheme.typography.labelMedium, color = MaterialTheme.colorScheme.onSecondary) }, shape = AppTokens.Shapes.small, border = BorderStroke(1.dp, MaterialTheme.colorScheme.outline), colors = AssistChipDefaults.assistChipColors(containerColor = MaterialTheme.colorScheme.secondary))
                        }
                        Box(modifier = Modifier.fillMaxWidth().aspectRatio(2.8f).background(AppTokens.Colors.surfaceVariant, AppTokens.Shapes.medium), contentAlignment = Alignment.Center) {
                            Text(text = if (showBalance.value) a.balance else "•••••••", style = MaterialTheme.typography.headlineMedium, color = MaterialTheme.colorScheme.onSurface)
                        }
                        Row(horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm), verticalAlignment = Alignment.CenterVertically) {
                            AssistChip(onClick = {}, label = { Text(text = "Transfer", style = MaterialTheme.typography.labelMedium, color = MaterialTheme.colorScheme.onSecondary) }, shape = AppTokens.Shapes.small, border = BorderStroke(1.dp, MaterialTheme.colorScheme.outline), colors = AssistChipDefaults.assistChipColors(containerColor = MaterialTheme.colorScheme.secondary))
                            AssistChip(onClick = {}, label = { Text(text = "Details", style = MaterialTheme.typography.labelMedium, color = MaterialTheme.colorScheme.onSurface) }, shape = AppTokens.Shapes.small, border = BorderStroke(1.dp, MaterialTheme.colorScheme.outline), colors = AssistChipDefaults.assistChipColors(containerColor = MaterialTheme.colorScheme.surface))
                        }
                    }
                }
            }
            item {
                Row(modifier = Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.SpaceBetween, verticalAlignment = Alignment.CenterVertically) {
                    Text(text = "Recent Activity", style = MaterialTheme.typography.headlineMedium, color = MaterialTheme.colorScheme.onSurface)
                    Row(horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm), verticalAlignment = Alignment.CenterVertically) {
                        AssistChip(onClick = { if (flags.contains("Income")) flags.remove("Income") else flags.add("Income") }, label = { Text(text = "Income", style = MaterialTheme.typography.labelMedium, color = if (flags.contains("Income")) MaterialTheme.colorScheme.onSecondary else MaterialTheme.colorScheme.onSurface) }, shape = AppTokens.Shapes.small, border = BorderStroke(1.dp, MaterialTheme.colorScheme.outline), colors = AssistChipDefaults.assistChipColors(containerColor = if (flags.contains("Income")) MaterialTheme.colorScheme.secondary else MaterialTheme.colorScheme.surface))
                        AssistChip(onClick = { if (flags.contains("Expense")) flags.remove("Expense") else flags.add("Expense") }, label = { Text(text = "Expense", style = MaterialTheme.typography.labelMedium, color = if (flags.contains("Expense")) MaterialTheme.colorScheme.onSecondary else MaterialTheme.colorScheme.onSurface) }, shape = AppTokens.Shapes.small, border = BorderStroke(1.dp, MaterialTheme.colorScheme.outline), colors = AssistChipDefaults.assistChipColors(containerColor = if (flags.contains("Expense")) MaterialTheme.colorScheme.secondary else MaterialTheme.colorScheme.surface))
                    }
                }
            }
            items(txs) { t ->
                Card(shape = AppTokens.Shapes.large, colors = CardDefaults.cardColors(containerColor = MaterialTheme.colorScheme.surface), elevation = CardDefaults.cardElevation(defaultElevation = AppTokens.ElevationMapping.level1.elevation), border = BorderStroke(1.dp, MaterialTheme.colorScheme.outline), modifier = Modifier.fillMaxWidth().heightIn(min = 72.dp)) {
                    Row(modifier = Modifier.fillMaxWidth().padding(AppTokens.Spacing.lg), horizontalArrangement = Arrangement.SpaceBetween, verticalAlignment = Alignment.CenterVertically) {
                        Row(verticalAlignment = Alignment.CenterVertically, horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.md)) {
                            Box(modifier = Modifier.size(32.dp).background(if (t.positive) AppTokens.Colors.success else AppTokens.Colors.error, AppTokens.Shapes.small))
                            Column(verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.xs), horizontalAlignment = Alignment.Start) {
                                Text(text = t.title, style = MaterialTheme.typography.titleMedium, color = MaterialTheme.colorScheme.onSurface)
                                Text(text = t.subtitle, style = MaterialTheme.typography.bodyMedium, color = MaterialTheme.colorScheme.onSurface)
                            }
                        }
                        Text(text = t.amount, style = MaterialTheme.typography.titleMedium, color = if (t.positive) AppTokens.Colors.success else AppTokens.Colors.error)
                    }
                }
            }
            item { Spacer(modifier = Modifier.height(AppTokens.Spacing.xxl)) }
        }
    }
}

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        WindowCompat.setDecorFitsSystemWindows(window, false)
        val controller = WindowInsetsControllerCompat(window, window.decorView)
        controller.systemBarsBehavior = WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
        controller.hide(WindowInsetsCompat.Type.navigationBars())
        setContent {
            AppTheme {
                Surface(color = MaterialTheme.colorScheme.background) {
                    RootScreen()
                }
            }
        }
    }
    override fun onWindowFocusChanged(hasFocus: Boolean) {
        super.onWindowFocusChanged(hasFocus)
        if (hasFocus) {
            val controller = WindowInsetsControllerCompat(window, window.decorView)
            controller.systemBarsBehavior = WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
            controller.hide(WindowInsetsCompat.Type.navigationBars())
        }
    }
}

@Preview(showBackground = true, backgroundColor = 0xFFFFFFFF, widthDp = 360, heightDp = 640)
@Composable
fun PreviewRoot() {
    AppTheme {
        RootScreen()
    }
}