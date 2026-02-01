#!/bin/bash

echo "====================================="
echo "日本旅行计划 GitHub Pages 部署脚本"
echo "====================================="
echo ""

# 检查git是否已配置用户信息
if [ -z "$(git config user.name)" ] || [ -z "$(git config user.email)" ]; then
    echo "⚠️  需要配置Git用户信息"
    echo ""
    read -p "请输入你的GitHub用户名: " username
    read -p "请输入你的邮箱: " email
    
    git config user.name "$username"
    git config user.email "$email"
    echo "✅ Git用户信息已配置"
    echo ""
fi

echo "📋 部署步骤："
echo ""
echo "1. 在GitHub上创建新仓库："
echo "   - 访问: https://github.com/new"
echo "   - 仓库名称: japan-travel-plan"
echo "   - 选择: Public (公开)"
echo "   - 不要勾选 README"
echo ""
read -p "按Enter键继续..."
echo ""

echo "2. 连接远程仓库并推送："
echo ""

# 获取GitHub用户名
GITHUB_USER=$(git config user.name)
if [ -z "$GITHUB_USER" ]; then
    read -p "请输入你的GitHub用户名: " GITHUB_USER
fi

# 添加远程仓库
git remote remove origin 2>/dev/null
git remote add origin "https://github.com/$GITHUB_USER/japan-travel-plan.git"

echo "   远程仓库已添加: https://github.com/$GITHUB_USER/japan-travel-plan"
echo ""

# 推送到GitHub
echo "   正在推送到GitHub..."
if git push -u origin master 2>/dev/null || git push -u origin main; then
    echo "   ✅ 推送成功！"
else
    echo "   ❌ 推送失败，请检查GitHub仓库是否已创建"
    echo ""
    echo "   手动推送命令："
    echo "   git remote add origin https://github.com/你的用户名/japan-travel-plan.git"
    echo "   git push -u origin master"
    exit 1
fi

echo ""
echo "3. 启用GitHub Pages："
echo "   - 访问: https://github.com/$GITHUB_USER/japan-travel-plan/settings/pages"
echo "   - Source (源): 选择 'Deploy from a branch'"
echo "   - Branch (分支): 选择 'master' 或 'main'"
echo "   - Folder (文件夹): 选择 '/ (root)'"
echo "   - 点击 'Save' 保存"
echo ""
read -p "按Enter键继续..."
echo ""

echo "4. 设置自定义域名（可选）："
echo "   - 在GitHub Pages设置页面"
echo "   - Custom domain (自定义域名): 输入你的域名"
echo "   - 勾选 'Enforce HTTPS'"
echo ""

echo "====================================="
echo "🎉 部署完成！"
echo "====================================="
echo ""
echo "📍 访问地址："
echo "   https://$GITHUB_USER.github.io/japan-travel-plan/"
echo ""
echo "⚠️  注意：GitHub Pages可能需要几分钟才能生效"
echo ""
echo "📧 如果页面无法访问，请检查："
echo "   1. GitHub仓库是否为Public (公开)"
echo "   2. GitHub Pages设置是否正确"
echo "   3. 等待5-10分钟后再访问"
echo ""
echo "====================================="
