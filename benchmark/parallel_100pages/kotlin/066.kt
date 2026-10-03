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

private const val NAME = "111StockListen"
private const val UI_TYPE = "Calendar"
private const val STYLE_THEME = "Retro Flat"
private const val LANG = "en"
private const val BASELINE_SIZE = "720x1280"

object AppTokens {
    object Colors {
        val primary = Color(0xFF214E34)
        val secondary = Color(0xFF2D6A4F)
        val tertiary = Color(0xFF6C757D)
        val background = Color(0xFFF8F1E5)
        val surface = Color(0xFFFFFBF0)
        val surfaceVariant = Color(0xFFE9DFC7)
        val outline = Color(0xFFD2C6AA)
        val success = Color(0xFF2B9348)
        val warning = Color(0xFFF4A261)
        val error = Color(0xFFD62828)
        val onPrimary = Color(0xFFFFFFFF)
        val onSecondary = Color(0xFFFFFFFF)
        val onTertiary = Color(0xFF1B1F22)
        val onBackground = Color(0xFF1B1F22)
        val onSurface = Color(0xFF1B1F22)
    }
    object TypographyTokens {
        val display = TextStyle(fontSize = 26.sp, fontWeight = FontWeight.SemiBold, lineHeight = 32.sp, letterSpacing = 0.sp)
        val headline = TextStyle(fontSize = 20.sp, fontWeight = FontWeight.Medium, lineHeight = 26.sp, letterSpacing = 0.sp)
        val title = TextStyle(fontSize = 16.sp, fontWeight = FontWeight.Medium, lineHeight = 20.sp, letterSpacing = 0.sp)
        val body = TextStyle(fontSize = 13.sp, fontWeight = FontWeight.Normal, lineHeight = 18.sp, letterSpacing = 0.sp)
        val label = TextStyle(fontSize = 11.sp, fontWeight = FontWeight.Medium, lineHeight = 14.sp, letterSpacing = 0.sp)
    }
    object Shapes {
        val small = RoundedCornerShape(6.dp)
        val medium = RoundedCornerShape(10.dp)
        val large = RoundedCornerShape(14.dp)
    }
    object Spacing {
        val xs = 4.dp
        val sm = 8.dp
        val md = 12.dp
        val lg = 16.dp
        val xl = 20.dp
        val xxl = 28.dp
        val xxxl = 40.dp
    }
    data class ShadowSpec(val elevation: Dp, val radius: Dp, val dy: Dp, val opacity: Float)
    object ElevationMapping {
        val level1 = ShadowSpec(1.dp, 3.dp, 1.dp, 0.10f)
        val level2 = ShadowSpec(3.dp, 6.dp, 3.dp, 0.14f)
        val level3 = ShadowSpec(6.dp, 10.dp, 5.dp, 0.16f)
        val level4 = ShadowSpec(10.dp, 14.dp, 7.dp, 0.18f)
        val level5 = ShadowSpec(14.dp, 18.dp, 9.dp, 0.20f)
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
            small = AppTokens.Shapes.small,
            medium = AppTokens.Shapes.medium,
            large = AppTokens.Shapes.large
        ),
        content = content
    )
}

data class DayTab(val id: Int, val label: String)
data class StockRow(val code: String, val name: String, val price: String, val change: String, val positive: Boolean)

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun RootScreen() {
    val days = listOf(DayTab(1, "Mon"), DayTab(2, "Tue"), DayTab(3, "Wed"), DayTab(4, "Thu"), DayTab(5, "Fri"))
    val selected = remember { mutableStateOf(days[0].id) }
    val sectors = remember { mutableStateListOf("All", "Tech", "Energy", "Finance") }
    val current = remember { mutableStateOf("All") }
    val items = remember {
        listOf(
            StockRow("600519", "Kweichow Moutai", "1687.3", "+1.24%", true),
            StockRow("000001", "Ping An Bank", "12.54", "-0.62%", false),
            StockRow("300750", "CATL", "192.8", "+0.87%", true),
            StockRow("601318", "Ping An Ins.", "44.2", "-1.12%", false),
            StockRow("600036", "CMBC", "36.9", "+0.15%", true),
            StockRow("688981", "SMIC", "56.4", "-0.48%", false)
        )
    }
    Scaffold(
        contentWindowInsets = WindowInsets(0),
        topBar = {
            CenterAlignedTopAppBar(
                title = {
                    Text(text = "Stock Calendar", style = MaterialTheme.typography.displayLarge, color = MaterialTheme.colorScheme.onSurface)
                }
            )
        },
        containerColor = MaterialTheme.colorScheme.background
    ) { padding ->
        Column(
            modifier = Modifier.fillMaxSize().padding(padding).padding(horizontal = AppTokens.Spacing.lg, vertical = AppTokens.Spacing.md),
            verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.md)
        ) {
            Card(
                shape = AppTokens.Shapes.large,
                colors = CardDefaults.cardColors(containerColor = MaterialTheme.colorScheme.surface),
                elevation = CardDefaults.cardElevation(defaultElevation = AppTokens.ElevationMapping.level2.elevation),
                border = BorderStroke(1.dp, MaterialTheme.colorScheme.outline)
            ) {
                Column(modifier = Modifier.fillMaxWidth().padding(AppTokens.Spacing.md), verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm)) {
                    Row(horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm)) {
                        days.forEach { d ->
                            val active = d.id == selected.value
                            Box(
                                modifier = Modifier.weight(1f).height(36.dp).background(if (active) MaterialTheme.colorScheme.primary else MaterialTheme.colorScheme.surfaceVariant, AppTokens.Shapes.small),
                                contentAlignment = Alignment.Center
                            ) {
                                Text(text = d.label, style = if (active) MaterialTheme.typography.titleMedium else MaterialTheme.typography.bodyMedium, color = if (active) MaterialTheme.colorScheme.onPrimary else MaterialTheme.colorScheme.onSurface)
                            }
                        }
                    }
                    Row(horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm), modifier = Modifier.fillMaxWidth()) {
                        sectors.forEach { s ->
                            val active = current.value == s
                            FilterChip(
                                selected = active,
                                onClick = { current.value = s },
                                label = { Text(text = s, style = if (active) MaterialTheme.typography.labelMedium else MaterialTheme.typography.labelMedium, color = if (active) MaterialTheme.colorScheme.onPrimary else MaterialTheme.colorScheme.onSurface) },
                                shape = AppTokens.Shapes.small,
                                border = BorderStroke(1.dp, MaterialTheme.colorScheme.outline),
                                colors = FilterChipDefaults.filterChipColors(containerColor = if (active) MaterialTheme.colorScheme.secondary else MaterialTheme.colorScheme.surface, selectedContainerColor = MaterialTheme.colorScheme.secondary)
                            )
                        }
                    }
                }
            }
            LazyColumn(
                verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm),
                contentPadding = PaddingValues(bottom = AppTokens.Spacing.xxxl)
            ) {
                items(items) { itx ->
                    Card(
                        modifier = Modifier.fillMaxWidth().heightIn(min = 72.dp),
                        shape = AppTokens.Shapes.medium,
                        colors = CardDefaults.cardColors(containerColor = MaterialTheme.colorScheme.surface),
                        elevation = CardDefaults.cardElevation(defaultElevation = AppTokens.ElevationMapping.level1.elevation),
                        border = BorderStroke(1.dp, MaterialTheme.colorScheme.outline)
                    ) {
                        Row(modifier = Modifier.fillMaxWidth().padding(AppTokens.Spacing.md), horizontalArrangement = Arrangement.SpaceBetween, verticalAlignment = Alignment.CenterVertically) {
                            Row(horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.md), verticalAlignment = Alignment.CenterVertically) {
                                Box(modifier = Modifier.size(28.dp).background(MaterialTheme.colorScheme.surfaceVariant, AppTokens.Shapes.small))
                                Column(verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.xs)) {
                                    Text(text = itx.name, style = MaterialTheme.typography.titleMedium, color = MaterialTheme.colorScheme.onSurface)
                                    Text(text = itx.code, style = MaterialTheme.typography.labelMedium, color = MaterialTheme.colorScheme.onSurface)
                                }
                            }
                            Row(horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.lg), verticalAlignment = Alignment.CenterVertically) {
                                Column(horizontalAlignment = Alignment.End) {
                                    Text(text = itx.price, style = MaterialTheme.typography.titleMedium, color = MaterialTheme.colorScheme.onSurface)
                                    Row(verticalAlignment = Alignment.CenterVertically, horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.xs)) {
                                        Box(modifier = Modifier.size(8.dp, 8.dp).background(if (itx.positive) AppTokens.Colors.success else AppTokens.Colors.error, AppTokens.Shapes.small))
                                        Text(text = itx.change, style = MaterialTheme.typography.labelMedium, color = if (itx.positive) AppTokens.Colors.success else AppTokens.Colors.error)
                                    }
                                }
                                Button(
                                    onClick = {},
                                    colors = ButtonDefaults.buttonColors(containerColor = MaterialTheme.colorScheme.primary, contentColor = MaterialTheme.colorScheme.onPrimary),
                                    shape = AppTokens.Shapes.small,
                                    modifier = Modifier.height(36.dp).width(76.dp)
                                ) {
                                    Text(text = "Detail", style = MaterialTheme.typography.labelMedium)
                                }
                            }
                        }
                    }
                }
            }
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

@Preview(showBackground = true, backgroundColor = 0xFFFFFFFF)
@Composable
fun PreviewRoot() {
    AppTheme {
        RootScreen()
    }
}