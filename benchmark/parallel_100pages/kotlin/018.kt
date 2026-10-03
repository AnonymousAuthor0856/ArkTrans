package com.example.singlefileui

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.aspectRatio
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.lazy.grid.GridCells
import androidx.compose.foundation.lazy.grid.LazyVerticalGrid
import androidx.compose.foundation.lazy.grid.items
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Shapes
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.Typography
import androidx.compose.material3.lightColorScheme
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsCompat
import androidx.core.view.WindowInsetsControllerCompat

private const val NAME = "018_FilterShop_en"
private const val UI_TYPE = "Media"
private const val STYLE_THEME = "Clay Morph"
private const val LANG = "en"
private const val BASELINE_SIZE = "720x1280"

object AppTokens {
    object Colors {
        val primary = Color(0xFFD7BBA8)
        val secondary = Color(0xFFA2C4C9)
        val tertiary = Color(0xFFB3C9A2)
        val background = Color(0xFFF0EBE3)
        val surface = Color(0xFFFFFFFF)
        val surfaceVariant = Color(0xFFE6E0D9)
        val outline = Color(0xFFDCD7CF)
        val success = Color(0xFF7EA87E)
        val warning = Color(0xFFD9B872)
        val error = Color(0xFFD98B8B)
        val onPrimary = Color(0xFF433E3A)
        val onSecondary = Color(0xFF433E3A)
        val onTertiary = Color(0xFF433E3A)
        val onBackground = Color(0xFF433E3A)
        val onSurface = Color(0xFF433E3A)
    }
    object TypographyTokens {
        val display = TextStyle(fontSize = 28.sp, fontWeight = FontWeight.Bold)
        val headline = TextStyle(fontSize = 22.sp, fontWeight = FontWeight.SemiBold)
        val title = TextStyle(fontSize = 16.sp, fontWeight = FontWeight.Medium)
        val body = TextStyle(fontSize = 14.sp, fontWeight = FontWeight.Normal, lineHeight = 20.sp)
        val label = TextStyle(fontSize = 12.sp, fontWeight = FontWeight.Medium, letterSpacing = 0.5.sp)
    }
    object Shapes {
        val small = RoundedCornerShape(8.dp)
        val medium = RoundedCornerShape(16.dp)
        val large = RoundedCornerShape(24.dp)
    }
    object Spacing {
        val xs = 4.dp
        val sm = 8.dp
        val md = 12.dp
        val lg = 16.dp
        val xl = 24.dp
    }
    data class ShadowSpec(val elevation: Dp, val color: Color, val offsetX: Dp, val offsetY: Dp, val blurRadius: Dp)
    object ElevationMapping {
        val level1 = ShadowSpec(3.dp, Color.Black.copy(alpha = 0.05f), 4.dp, 4.dp, 8.dp)
        val level2 = ShadowSpec(6.dp, Color.Black.copy(alpha = 0.08f), 6.dp, 6.dp, 12.dp)
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
)

private val AppTypography = Typography(
    displaySmall = AppTokens.TypographyTokens.display,
    headlineSmall = AppTokens.TypographyTokens.headline,
    titleMedium = AppTokens.TypographyTokens.title,
    bodyMedium = AppTokens.TypographyTokens.body,
    labelMedium = AppTokens.TypographyTokens.label,
)

@Composable
fun AppTheme(content: @Composable () -> Unit) {
    MaterialTheme(
        colorScheme = AppColorScheme,
        typography = AppTypography,
        shapes = Shapes(small = AppTokens.Shapes.small, medium = AppTokens.Shapes.medium, large = AppTokens.Shapes.large),
        content = content
    )
}

data class Filter(val id: String, val name: String)
data class FilterItem(val id: Int, val name: String, val author: String, val price: String, val color: Color)

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun RootScreen() {
    val filters = remember { listOf(Filter("vintage", "Vintage"), Filter("grain", "Grain"), Filter("b&w", "B&W"), Filter("neon", "Neon")) }
    var selectedFilter by remember { mutableStateOf("vintage") }
    val items = remember {
        listOf(
            FilterItem(1, "Redscale", "by UserA", "$4.99", AppTokens.Colors.error),
            FilterItem(2, "Sepia Tone", "by UserB", "$2.99", AppTokens.Colors.primary),
            FilterItem(3, "Aqua", "by UserC", "$4.99", AppTokens.Colors.secondary),
            FilterItem(4, "Forest", "by UserD", "$3.99", AppTokens.Colors.tertiary),
            FilterItem(5, "Golden Hour", "by UserE", "$5.99", AppTokens.Colors.warning),
            FilterItem(6, "Monochrome", "by UserF", "$1.99", AppTokens.Colors.outline),
        )
    }

    Scaffold(
        contentWindowInsets = androidx.compose.foundation.layout.WindowInsets(0),
        containerColor = AppTokens.Colors.background,
        topBar = { TopBarSection(filters, selectedFilter, onFilterSelected = { selectedFilter = it }) },
        bottomBar = { BottomBarSection() }
    ) { paddingValues ->
        LazyVerticalGrid(
            columns = GridCells.Fixed(2),
            modifier = Modifier.fillMaxSize().padding(paddingValues),
            contentPadding = PaddingValues(AppTokens.Spacing.lg),
            horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.md),
            verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.md)
        ) {
            items(items, key = { it.id }) { item ->
                FilterCard(item)
            }
        }
    }
}

@Composable
fun TopBarSection(filters: List<Filter>, selectedFilter: String, onFilterSelected: (String) -> Unit) {
    Column(
        modifier = Modifier.fillMaxWidth().padding(horizontal = AppTokens.Spacing.lg, vertical = AppTokens.Spacing.md)
    ) {
        Text("Filter Shop", style = MaterialTheme.typography.displaySmall, color = MaterialTheme.colorScheme.onBackground)
        Spacer(modifier = Modifier.height(AppTokens.Spacing.md))
        Row(modifier = Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm)) {
            filters.forEach { filter ->
                val isSelected = filter.id == selectedFilter
                Box(
                    modifier = Modifier
                        .clip(AppTokens.Shapes.large)
                        .clickable { onFilterSelected(filter.id) }
                        .background(if (isSelected) AppTokens.Colors.primary else AppTokens.Colors.surface)
                        .border(
                            width = 2.dp, 
                            color = if(isSelected) AppTokens.Colors.onBackground.copy(alpha=0.1f) else AppTokens.Colors.outline, 
                            shape = AppTokens.Shapes.large
                        )
                        .padding(horizontal = AppTokens.Spacing.md, vertical = AppTokens.Spacing.sm)
                ) {
                    Text(
                        filter.name,
                        style = MaterialTheme.typography.labelMedium,
                        color = if (isSelected) AppTokens.Colors.onPrimary else AppTokens.Colors.onBackground
                    )
                }
            }
        }
    }
}

@Composable
fun FilterCard(item: FilterItem) {
    Card(
        shape = AppTokens.Shapes.large,
        elevation = CardDefaults.cardElevation(defaultElevation = AppTokens.ElevationMapping.level1.elevation),
        colors = CardDefaults.cardColors(containerColor = AppTokens.Colors.surface)
    ) {
        Column(Modifier.padding(AppTokens.Spacing.sm)) {
            Box(
                modifier = Modifier
                    .fillMaxWidth()
                    .aspectRatio(1f)
                    .clip(AppTokens.Shapes.medium)
                    .background(item.color)
            )
            Column(Modifier.padding(AppTokens.Spacing.sm)) {
                Text(item.name, style = MaterialTheme.typography.titleMedium, fontWeight = FontWeight.Bold)
                Text(item.author, style = MaterialTheme.typography.labelMedium, color = AppTokens.Colors.onSurface.copy(alpha = 0.6f))
                Spacer(Modifier.height(AppTokens.Spacing.sm))
                Text(item.price, style = MaterialTheme.typography.titleMedium, color = AppTokens.Colors.primary, fontWeight = FontWeight.Bold)
            }
        }
    }
}


@Composable
fun BottomBarSection() {
    Surface(
        modifier = Modifier.fillMaxWidth(),
        color = AppTokens.Colors.surface,
        shadowElevation = AppTokens.ElevationMapping.level2.elevation
    ) {
        Row(
            modifier = Modifier.padding(horizontal = AppTokens.Spacing.lg, vertical = AppTokens.Spacing.md),
            verticalAlignment = Alignment.CenterVertically,
            horizontalArrangement = Arrangement.SpaceBetween
        ) {
            Text("3 items in cart", style = MaterialTheme.typography.bodyMedium)
            Button(
                onClick = {},
                shape = AppTokens.Shapes.large,
                colors = ButtonDefaults.buttonColors(
                    containerColor = AppTokens.Colors.primary,
                    contentColor = AppTokens.Colors.onPrimary
                ),
                 elevation = ButtonDefaults.buttonElevation(defaultElevation = AppTokens.ElevationMapping.level1.elevation)
            ) {
                Row(verticalAlignment = Alignment.CenterVertically, horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm)) {
                    Box(modifier = Modifier.size(16.dp).clip(CircleShape).background(AppTokens.Colors.onPrimary.copy(alpha = 0.2f)))
                    Text("Checkout", style = MaterialTheme.typography.titleMedium)
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
        controller.hide(WindowInsetsCompat.Type.systemBars())
        setContent {
            AppTheme {
                Surface(modifier = Modifier.fillMaxSize(), color = MaterialTheme.colorScheme.background) {
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
            controller.hide(WindowInsetsCompat.Type.systemBars())
        }
    }
}

@Preview(showBackground = true, backgroundColor = 0xFFF0EBE3)
@Composable
fun PreviewRoot() {
    AppTheme {
        RootScreen()
    }
}
